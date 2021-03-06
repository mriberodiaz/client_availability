# Copyright 2019, Google LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Internal dispatcher for training loops."""

import contextlib
import os.path
import pprint
import time
from typing import Any, Callable, Dict, List, Optional

from absl import logging
import pandas as pd
import tensorflow as tf
import tensorflow_federated as tff

from utils import checkpoint_manager
from utils import metrics_manager
from utils import utils_impl

def format_size(size):
  """A helper function for creating a human-readable size."""
  size = float(size)
  for unit in ['bit','Kibit','Mibit','Gibit']:
    if size < 1024.0:
      return "{size:3.2f}{unit}".format(size=size, unit=unit)
    size /= 1024.0
  return "{size:.2f}{unit}".format(size=size, unit='TiB')

def set_sizing_environment():
  """Creates an environment that contains sizing information."""
  # Creates a sizing executor factory to output communication cost
  # after the training finishes. Note that sizing executor only provides an
  # estimate (not exact) of communication cost, and doesn't capture cases like
  # compression of over-the-wire representations. However, it's perfect for
  # demonstrating the effect of compression in this tutorial.
  sizing_factory = tff.framework.sizing_executor_factory()

  # TFF has a modular runtime you can configure yourself for various
  # environments and purposes, and this example just shows how to configure one
  # part of it to report the size of things.
  context = tff.framework.ExecutionContext(executor_fn=sizing_factory)
  tff.framework.set_default_context(context)

  return sizing_factory


def create_if_not_exists(path):
  try:
    tf.io.gfile.makedirs(path)
  except tf.errors.OpError:
    logging.info('Skipping creation of directory [%s], already exists', path)


def _setup_outputs(root_output_dir,
                   experiment_name,
                   hparam_dict,
                   write_metrics_with_bz2=True,
                   rounds_per_profile=0):
  """Set up directories for experiment loops, write hyperparameters to disk."""

  if not experiment_name:
    raise ValueError('experiment_name must be specified.')

  create_if_not_exists(root_output_dir)

  checkpoint_dir = os.path.join(root_output_dir, 'checkpoints', experiment_name)
  create_if_not_exists(checkpoint_dir)
  checkpoint_mngr = checkpoint_manager.FileCheckpointManager(checkpoint_dir)

  results_dir = os.path.join(root_output_dir, 'results', experiment_name)
  create_if_not_exists(results_dir)
  metrics_mngr = metrics_manager.ScalarMetricsManager(
      results_dir, use_bz2=write_metrics_with_bz2)

  summary_logdir = os.path.join(root_output_dir, 'logdir', experiment_name)
  create_if_not_exists(summary_logdir)
  summary_writer = tf.summary.create_file_writer(summary_logdir)

  if hparam_dict:
    hparam_dict['metrics_file'] = metrics_mngr.metrics_filename
    hparams_file = os.path.join(results_dir, 'hparams.csv')
    utils_impl.atomic_write_to_csv(pd.Series(hparam_dict), hparams_file)

  logging.info('Writing...')
  logging.info('    checkpoints to: %s', checkpoint_dir)
  logging.info('    metrics csv to: %s', metrics_mngr.metrics_filename)
  logging.info('    summaries to: %s', summary_logdir)

  @contextlib.contextmanager
  def profiler(round_num):
    if (rounds_per_profile > 0 and round_num % rounds_per_profile == 0):
      with tf.profiler.experimental.Profile(summary_logdir):
        yield
    else:
      yield

  return checkpoint_mngr, metrics_mngr, summary_writer, profiler


def _write_metrics(metrics_mngr, summary_writer, metrics, round_num):
  """Atomic metrics writer which inlines logic from MetricsHook class."""
  if not isinstance(metrics, dict):
    raise TypeError('metrics should be type `dict`.')
  if not isinstance(round_num, int):
    raise TypeError('round_num should be type `int`.')

  flat_metrics = metrics_mngr.update_metrics(round_num, metrics)
  logging.info('Evaluation at round {:d}:\n{!s}'.format(
      round_num, pprint.pformat(flat_metrics)))

  # Also write metrics to a tf.summary logdir
  with summary_writer.as_default():
    for name, val in flat_metrics.items():
      tf.summary.scalar(name, val, step=round_num)


def _compute_numpy_l2_difference(model, previous_model):
  squared_norms = tf.nest.map_structure(lambda x, y: tf.linalg.norm(x - y)**2,
                                        model, previous_model)
  l2_total_tensor = tf.reduce_sum(tf.nest.flatten(squared_norms))**0.5
  return l2_total_tensor.numpy()


def run(validation_fn: Callable[[Any], Dict[str, float]],
        total_rounds: int,
        experiment_name: str,
        test_fn: Optional[Callable[[Any], Dict[str, float]]] = None,
        root_output_dir: Optional[str] = '/tmp/fed_opt',
        hparam_dict: Optional[Dict[str, Any]] = None,
        write_metrics_with_bz2: Optional[bool] = True):
  """Runs federated training for a given `tff.templates.IterativeProcess`.

  We assume that the iterative process has the following functional type
  signatures:

    *   `initialize`: `( -> S@SERVER)` where `S` represents the server state.
    *   `next`: `<S@SERVER, {B*}@CLIENTS> -> <S@SERVER, T@SERVER>` where `S`
        represents the server state, `{B*}` represents the client datasets,
        and `T` represents a python `Mapping` object.

  Moreover, the server state must have an attribute `model` that can be passed
  to `validation_fn`, `train_eval_fn`, and `test_fn` (if given).

  Args:
    iterative_process: A `tff.templates.IterativeProcess` instance to run.
    client_datasets_fn: Function accepting an integer argument (the round
      number) and returning a list of client datasets to use as federated data
      for that round, and a list of the corresponding client ids.
    validation_fn: A callable accepting the `model` attribute of the iterative
      process state and returning a dict of evaluation metrics. Used to compute
      validation metrics throughout the training process.
    total_rounds: The number of federated training rounds to perform.
    experiment_name: The name of the experiment being run. This will be appended
      to the `root_output_dir` for purposes of writing outputs.
    train_eval_fn: An optional callable accepting the `model` attribute of the
      iterative process state and returning a dict of evaluation metrics. Used
      to compute training metrics over the entire training dataset throughout
      the course of the iterative process. If set to `None`, no such evaluation
      is done.
    test_fn: An optional callable accepting the `model` attribute of the
      iterative process state and returning a dict of test metrics. Used to
      compute test metrics at the end of the training process.
    root_output_dir: The name of the root output directory for writing
      experiment outputs.
    hparam_dict: An optional dictionary specifying hyperparameters of the
      experiment. If provided, the hyperparameters will be written to CSV.
    write_metrics_with_bz2: Whether to use `bz2` compression when writing
      metrics to CSV.
    rounds_per_eval: How often to compute validation metrics.
    rounds_per_checkpoint: How often to checkpoint the iterative process state.
      If you expect the job to restart frequently, this should be small. If no
      interruptions are expected, this can be made larger.
    rounds_per_train_eval: How often to compute metrics over the entire training
      dataset. Note that this is only done if a `train_eval_fn` argument is
      supplied.
    rounds_per_profile: Experimental setting. If set to a value greater than 0,
      this dictates how often a TensorFlow profiler is run.

  Returns:
    The final `state` of the iterative process after training.
  """
  if not callable(validation_fn):
    raise TypeError('validation_fn should be callable.')
  if test_fn is not None and not callable(test_fn):
    raise TypeError('test_fn should be callable.')

  # Create a environment to get communication cost.
  environment = set_sizing_environment()

  logging.info('Starting iterative_process training loop...')
  initial_state = iterative_process.initialize()
  logging.info( ' Initilized!  keys: \n')
  for k in initial_state.__dict__.keys():
    logging.info(f'             {k}')

  if not hasattr(initial_state, 'model'):
    raise TypeError('The server state must have a model attribute.')

  checkpoint_mngr, metrics_mngr, summary_writer, profiler = _setup_outputs(
      root_output_dir, experiment_name, hparam_dict, write_metrics_with_bz2,
      rounds_per_profile)

  logging.info('Asking checkpoint manager to load checkpoint.')
  state, round_num = checkpoint_mngr.load_latest_checkpoint(initial_state)

  if state is None:
    logging.info('No model to test')
    return
  else:
    logging.info('Restarted from checkpoint round %d', round_num)
    round_num += 1  # Increment to avoid overwriting current checkpoint
    # metrics_mngr.clear_rounds_after(last_valid_round_num=round_num - 1)

    loop_start_time = time.time()
    test_start_time = time.time()
    test_metrics = test_fn(state.model)
    test_metrics['evaluate_secs'] = time.time() - test_start_time
    metrics['test'] = test_metrics
    _write_metrics(metrics_mngr, summary_writer, metrics, total_rounds)
