 #!/bin/bash

### CIFAR

for t in 5 7
do

# all avail 
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/TEST_SEED/ --schedule=none --experiment_name=fed_avg_TEST_SEED1 --sine_wave=False --var_q_clients=0.
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=importance --beta=0.001  --experiment_name=cifar_importance_ALL_AVAIL$t --sine_wave=False --var_q_clients=0.

# Uneven

    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=importance --beta=0.001  --experiment_name=cifar_importance_INVERSE_A$t --sine_wave=False --var_q_clients=85
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=loss --experiment_name=cifar_loss_INVERSE_A$t --sine_wave=False --var_q_clients=85 --loss_pool_size=15

# Scarce
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=none --experiment_name=cifar_fedavg_SMALL_A$t --sine_wave=False --var_q_clients=0.2
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=importance --beta=0.001  --experiment_name=cifar_importance_SMALL_A$t --sine_wave=False --var_q_clients=0.2

# home-device 
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=none --experiment_name=cifar_fedavg_INDEP$t --sine_wave=False --var_q_clients=0.5
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=importance --beta=0.001 --experiment_name=cifar_importance_INDEP$t --sine_wave=False --var_q_clients=0.5

# Smartphones
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162 --root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=none  --experiment_name=cifar_adam_WAVE$t --sine_wave=True --var_q_clients=.25
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=cifar100 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --server_learning_rate=3.162.--root_output_dir=/home/monica/RESULTS/client_availability/cifar_all_avail_models_rebuttal/ --schedule=importance --beta=0.001 --experiment_name=cifar_adam_importance_WAVE$t --sine_wave=True --var_q_clients=.25

done 

### SHAKESPEARE
for t in 5 7
do
    # inverse
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/ --schedule=none --server_learning_rate=1. --experiment_name=shakespeare_fedavg_INVERSE_A$t --sine_wave=False --var_q_clients=82
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/ --schedule=importance --server_learning_rate=3. --experiment_name=shakespeare_importance_INVERSE_A$t --sine_wave=False --var_q_clients=59 --beta=0.001


    # wave
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/ --schedule=none --server_learning_rate=1. --experiment_name=shakespeare_fedavg_WAVE$t --sine_wave=True --var_q_clients=.25
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/ --schedule=importance --server_learning_rate=3. --experiment_name=shakespeare_importance_WAVE$t --sine_wave=True --var_q_clients=.25 --beta=0.001


    #all avail 
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/ --schedule=none --server_learning_rate=1. --experiment_name=shakespeare_fedavg_ALL_AVAIL$t --sine_wave=False --var_q_clients=0.
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/ --schedule=importance --server_learning_rate=3. --experiment_name=shakespeare_importance_ALL_AVAIL$t --sine_wave=False --var_q_clients=0. --beta=0.001

    # small
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/ --schedule=none --server_learning_rate=1. --experiment_name=shakespeare_fedavg_SMALL_A$t --sine_wave=False --var_q_clients=0.2
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/ --schedule=importance --server_learning_rate=3. --experiment_name=shakespeare_importance_SMALL_A$t --sine_wave=False --var_q_clients=0.2 --beta=0.001


    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal/--schedule=none --server_learning_rate=1. --experiment_name=shakespeare_fedavg_INDEP$t --sine_wave=False --var_q_clients=0.5
    bazel run main:federated_trainer -- --client_datasets_random_seed=$t --task=shakespeare --total_rounds=500 --client_optimizer=sgd --client_learning_rate=1. --client_batch_size=4 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/shakespeare_all_avail_models_rebuttal --schedule=importance --server_learning_rate=1. --experiment_name=shakespeare_importance_INDEP$t --sine_wave=False --var_q_clients=0.5 --beta=0.001

done 

### SYNTHETIC

# for t in 1 2
# do

# done