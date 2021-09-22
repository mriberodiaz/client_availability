 #!/bin/bash

#ALL
#bazel run main:federated_trainer -- --task=cifar100 --total_rounds=300 --client_optimizer=sgd --client_learning_rate=0.0316228 --client_batch_size=20 --server_optimizer=adam  --server_adam_epsilon=0.1 --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=$lr --root_output_dir=/home/monica/RESULTS/client_availability/cifar_adam/ --schedule=importance --beta=0.001 --experiment_name=cifar_adam_importance_ALL_AVAIL_slr3 --sine_wave=False --var_q_clients=0.



#small
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.0316228 --client_batch_size=20 --server_optimizer=adam  --server_adam_epsilon=0.1 --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3. --root_output_dir=/home/monica/RESULTS/client_availability/cifar_adam/ --schedule=importance --beta=0.001 --experiment_name=cifar_adam_importance_SMALL_A_slr3 --sine_wave=False --var_q_clients=0.2

#Inverse
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.0316228 --client_batch_size=20 --server_optimizer=adam  --server_adam_epsilon=0.1 --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3. --root_output_dir=/home/monica/RESULTS/client_availability/cifar_adam/ --schedule=importance --beta=0.001 --experiment_name=cifar_adam_importance_INVERSE_A_slr3 --sine_wave=False --var_q_clients=85

#large
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.0316228 --client_batch_size=20 --server_optimizer=adam  --server_adam_epsilon=0.1 --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3. --root_output_dir=/home/monica/RESULTS/client_availability/cifar_adam/ --schedule=importance --beta=0.001 --experiment_name=cifar_adam_importance_LARGE_A_slr3 --sine_wave=False --var_q_clients=0.7

#wave
bazel run main:federated_trainer -- --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.0316228 --client_batch_size=20 --server_optimizer=adam  --server_adam_epsilon=0.1 --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.--root_output_dir=/home/monica/RESULTS/client_availability/cifar_adam/ --schedule=importance --beta=0.001 --experiment_name=cifar_adam_importance_WAVE_slr3 --sine_wave=True --var_q_clients=.25


