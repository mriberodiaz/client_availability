 #!/bin/bash

for lr in 1.5 2 3
do
	bazel run main:federated_trainer -- --task=cifar100 --total_rounds=300 --client_optimizer=sgd --client_learning_rate=0.0316228 --client_batch_size=20 --server_optimizer=adam  --server_adam_epsilon=0.1 --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=$lr --root_output_dir=/home/monica/RESULTS/client_availability/cifar_adam/ --schedule=importance --beta=0.001 --experiment_name=cifar_adam_importance_ALL_AVAIL_slr$lr --sine_wave=False --var_q_clients=0.
done 
