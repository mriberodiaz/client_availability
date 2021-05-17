 #!/bin/bash

#all avail 
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=none --experiment_name=cifar_fedavg_ALL_AVAIL --sine_wave=False --var_q_clients=0.
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=importance --beta=0.001  --experiment_name=cifar_importance_ALL_AVAIL --sine_wave=False --var_q_clients=0.
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=loss --experiment_name=cifar_loss_ALL_AVAIL --sine_wave=False --var_q_clients=0. --loss_pool_size=15


bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=none --experiment_name=cifar_fedavg_LARGE_A --sine_wave=False --var_q_clients=0.7
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=importance --beta=0.001  --experiment_name=cifar_importance_LARGE_A --sine_wave=False --var_q_clients=0.7
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=loss --experiment_name=cifar_loss_LARGE_A --sine_wave=False --var_q_clients=0.7 --loss_pool_size=15

bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=none --experiment_name=cifar_fedavg_SMALL_A --sine_wave=False --var_q_clients=0.2
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=importance --beta=0.001  --experiment_name=cifar_importance_SMALL_A --sine_wave=False --var_q_clients=0.2
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=loss --experiment_name=cifar_loss_SMALL_A --sine_wave=False --var_q_clients=0.2 --loss_pool_size=15

bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=none --experiment_name=cifar_fedavg_INVERSE_A --sine_wave=False --var_q_clients=85
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=importance --beta=0.001  --experiment_name=cifar_importance_INVERSE_A --sine_wave=False --var_q_clients=85
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models/ --schedule=loss --experiment_name=cifar_loss_INVERSE_A --sine_wave=False --var_q_clients=85 --loss_pool_size=15