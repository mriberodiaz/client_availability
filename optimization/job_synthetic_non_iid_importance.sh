 #!/bin/bash
# bazel run main:federated_trainer -- --task=synthetic --alpha=0. --beta_data=1. --iid=1 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/syntheticWaveFalseLong/ --schedule=none --server_learning_rate=1. --experiment_name=synthetic01_iid_fedavg_waveFalse --sine_wave=False --var_q_clients=0.5
# bazel run main:federated_trainer -- --task=synthetic --alpha=0. --beta_data=1. --iid=1 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/syntheticWaveFalseLong/ --schedule=importance --server_learning_rate=1. --experiment_name=synthetic01_iid_importance_waveFalse --sine_wave=False --var_q_clients=0.5 --beta=0.001
# bazel run main:federated_trainer -- --task=synthetic --alpha=0. --beta_data=1. --iid=1 --total_rounds=1000 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/syntheticWaveFalseLong/ --schedule=loss --server_learning_rate=1. --experiment_name=synthetic01_iid_loss_waveFalse --sine_wave=False --var_q_clients=0.5 --loss_pool_size=30

# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_avail_non_iid/ --schedule=none --server_learning_rate=1. --experiment_name=synthetic11_fedavg_waveFalse --sine_wave=False --var_q_clients=0. --num_users=100
# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_avail_non_iid/  --schedule=importance --server_learning_rate=1. --experiment_name=synthetic11_importance_waveFalse --sine_wave=False --var_q_clients=0. --beta=0.001 --num_users=100
# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_avail_non_iid/ --schedule=loss --server_learning_rate=1. --experiment_name=synthetic11_loss_waveFalse --sine_wave=False --var_q_clients=0. --loss_pool_size=15 --num_users=100

# bazel run main:federated_trainer -- --task=synthetic --alpha=0. --beta_data=0. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_avail_non_iid/ --schedule=none --server_learning_rate=1. --experiment_name=synthetic00_fedavg_waveFalse --sine_wave=False --var_q_clients=0. --num_users=100
# bazel run main:federated_trainer -- --task=synthetic --alpha=0. --beta_data=0. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_avail_non_iid/ --schedule=importance --server_learning_rate=1. --experiment_name=synthetic00_importance_waveFalse --sine_wave=False --var_q_clients=0. --beta=0.001 --num_users=100
# bazel run main:federated_trainer -- --task=synthetic --alpha=0. --beta_data=0. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_avail_non_iid/ --schedule=loss --server_learning_rate=1. --experiment_name=synthetic00_loss_waveFalse --sine_wave=False --var_q_clients=0. --loss_pool_size=15 --num_users=100

# IID AVAIL MODEL aka waveFalse
#bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/ --schedule=none --server_learning_rate=1. --experiment_name=synthetic11_fedavg_waveFalse --sine_wave=False --var_q_clients=0.5 --num_users=100
bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/  --schedule=importance --server_learning_rate=1. --experiment_name=synthetic11_importance_unif_waveFalse --sine_wave=False --var_q_clients=0.5 --beta=0.001 --num_users=100 --initialize_p=False
#bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/ --schedule=loss --server_learning_rate=1. --experiment_name=synthetic11_loss_waveFalse --sine_wave=False --var_q_clients=0.5 --loss_pool_size=15 --num_users=100


# INVERSE aka waveFalse
#bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/ --schedule=none --server_learning_rate=1. --experiment_name=synthetic11_fedavg_INVERSE_A --sine_wave=False --var_q_clients=56 --num_users=100
bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/  --schedule=importance --server_learning_rate=1. --experiment_name=synthetic11_importance_unif_INVERSE_A --sine_wave=False --var_q_clients=56 --beta=0.001 --num_users=100 --initialize_p=False
#bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/ --schedule=loss --server_learning_rate=1. --experiment_name=synthetic11_loss_INVERSE_A --sine_wave=False --var_q_clients=34 --loss_pool_size=15 --num_users=100

# # SMALL_A
# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/ --schedule=none --server_learning_rate=1. --experiment_name=synthetic11_fedavg_SMALL_A --sine_wave=False --var_q_clients=0.2 --num_users=100
# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/  --schedule=importance --server_learning_rate=1. --experiment_name=synthetic11_importance_SMALL_A --sine_wave=False --var_q_clients=0.2 --beta=0.001 --num_users=100
# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/ --schedule=loss --server_learning_rate=1. --experiment_name=synthetic11_loss_SMALL_A --sine_wave=False --var_q_clients=0.2 --loss_pool_size=15 --num_users=100

# #WAVE
# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/ --schedule=none --server_learning_rate=1. --experiment_name=synthetic11_fedavg_WAVE --sine_wave=True --var_q_clients=0.25 --num_users=100
# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/  --schedule=importance --server_learning_rate=1. --experiment_name=synthetic11_importance_WAVE --sine_wave=True --var_q_clients=.25 --beta=0.001 --num_users=100
# bazel run main:federated_trainer -- --task=synthetic --alpha=1. --beta_data=1. --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.01 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=10 --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic_all_models_non_iid/ --schedule=loss --server_learning_rate=1. --experiment_name=synthetic11_loss_WAVE --sine_wave=True --var_q_clients=0.25 --loss_pool_size=15 --num_users=100
