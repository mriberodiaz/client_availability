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
"""Federated EMNIST character recognition library using TFF."""

import functools
from typing import Callable, Optional

from absl import logging
import tensorflow as tf
import tensorflow_federated as tff

from utils import test
from utils.datasets import synthetic_dataset

def create_logistic_regression_model():
  """Logistic regression model.

  Returns:
    An uncompiled `tf.keras.Model`.
  """
  model = tf.keras.models.Sequential([
      tf.keras.layers.Dense(
        10, 
        input_shape = (60,), 
        ),
      ])
  return model

def run_federated(
    iterative_process_builder: Callable[..., tff.templates.IterativeProcess],
    client_epochs_per_round: int,
    client_batch_size: int,
    clients_per_round: int,
    schedule: Optional[str]='none',
    beta: Optional[float] = 0.,
    max_batches_per_client: Optional[int] = -1,
    client_datasets_random_seed: Optional[int] = None,
    model: Optional[str] = 'cnn',
    total_rounds: Optional[int] = 1500,
    experiment_name: Optional[str] = 'federated_synthetic',
    root_output_dir: Optional[str] = '/tmp/fed_opt',
    max_eval_batches: Optional[int] = None,
    alpha: Optional[float] = 0.,
    beta_data: Optional[float] = 0.,
    iid: Optional[int] = 0,
    num_users: Optional[int] = 1000,
    **kwargs):
  """Runs an iterative process on the EMNIST character recognition task.

  This method will load and pre-process dataset and construct a model used for
  the task. It then uses `iterative_process_builder` to create an iterative
  process that it applies to the task, using
  `federated_research.utils.training_loop`.

  We assume that the iterative process has the following functional type
  signatures:

    *   `initialize`: `( -> S@SERVER)` where `S` represents the server state.
    *   `next`: `<S@SERVER, {B*}@CLIENTS> -> <S@SERVER, T@SERVER>` where `S`
        represents the server state, `{B*}` represents the client datasets,
        and `T` represents a python `Mapping` object.

  Moreover, the server state must have an attribute `model` of type
  `tff.learning.ModelWeights`.

  Args:
    iterative_process_builder: A function that accepts a no-arg `model_fn`, and
      returns a `tff.templates.IterativeProcess`. The `model_fn` must return a
      `tff.learning.Model`.
    client_epochs_per_round: An integer representing the number of epochs of
      training performed per client in each training round.
    client_batch_size: An integer representing the batch size used on clients.
    clients_per_round: An integer representing the number of clients
      participating in each round.
    max_batches_per_client: An optional int specifying the number of batches
      taken by each client at each round. If `-1`, the entire client dataset is
      used.
    client_datasets_random_seed: An optional int used to seed which clients are
      sampled at each round. If `None`, no seed is used.
    model: A string specifying the model used for character recognition.
      Can be one of `cnn` and `2nn`, corresponding to a CNN model and a densely
      connected 2-layer model (respectively).
    total_rounds: The number of federated training rounds.
    experiment_name: The name of the experiment being run. This will be appended
      to the `root_output_dir` for purposes of writing outputs.
    root_output_dir: The name of the root output directory for writing
      experiment outputs.
    max_eval_batches: If set to a positive integer, evaluation datasets are
      capped to at most that many batches. If set to None or a nonpositive
      integer, the full evaluation datasets are used.
    **kwargs: Additional arguments configuring the training loop. For details
      on supported arguments, see
      `federated_research/utils/training_utils.py`.
  """

  train_data, test_data, fed_test_data = synthetic_dataset.generate_federated_softmax_data(
    batch_size = client_batch_size, 
    client_epochs_per_round= client_epochs_per_round,
    test_batch_size = 100,
    alpha=alpha,
    beta=beta_data,
    iid = iid, 
    num_users=num_users)

  input_spec = train_data.create_tf_dataset_for_client(
      train_data.client_ids[0]).element_spec


  model_builder = functools.partial(
        create_logistic_regression_model)


  loss_builder = tf.keras.losses.SparseCategoricalCrossentropy
  metrics_builder = lambda: [tf.keras.metrics.SparseCategoricalAccuracy()]

  def tff_model_fn() -> tff.learning.Model:
    return tff.learning.from_keras_model(
        keras_model=model_builder(),
        input_spec=input_spec,
        loss=loss_builder(),
        metrics=metrics_builder())

  training_process = iterative_process_builder(tff_model_fn)

  evaluate_fn = training_utils.build_evaluate_fn(
      eval_dataset=test_data,
      model_builder=model_builder,
      loss_builder=loss_builder,
      metrics_builder=metrics_builder)
  test_fn = training_utils.build_unweighted_test_fn(
      eval_dataset=fed_test_data,
      model_builder=model_builder,
      loss_builder=loss_builder,
      metrics_builder=metrics_builder)

  logging.info('Testing model:')


  test.run(
      iterative_process=training_process,
      client_datasets_fn=client_datasets_fn,
      validation_fn=evaluate_fn,
      test_fn=evaluate_fn,
      total_rounds=total_rounds,
      experiment_name=experiment_name,
      root_output_dir=root_output_dir,
      **kwargs)

