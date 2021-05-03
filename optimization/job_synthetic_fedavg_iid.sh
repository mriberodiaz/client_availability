 #!/bin/bash
for bd in 0 0.25 0.5
do
	for clients in 2 5 10
	do
		bazel run main:federated_trainer -- --task=synthetic --alpha=0 --beta_data=$bd --iid=1 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=$clients --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic/iid/ --schedule=none --server_learning_rate=1.0 --experiment_name=synthetic_iid_${bd}_cl${clients}			
	done
done


 