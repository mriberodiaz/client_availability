 #!/bin/bash
 for alpha in 0 0.25 0.5
 do
	for bd in 0 0.25 0.25
	do
		for beta in 0.01 0.001 0.002 0.005
		do
			for clients in 2 5 10
			do
				for slr in 0.1 1. 5. 10.
				do
				bazel run main:federated_trainer -- --task=synthetic --alpha=$alpha --beta_data=$bd --iid=0 --total_rounds=500 --client_optimizer=sgd --client_learning_rate=0.1 --client_batch_size=20 --server_optimizer=sgd  --clients_per_round=$clients --client_epochs_per_round=1 --root_output_dir=/home/monica/RESULTS/client_availability/synthetic/ --schedule=importance --beta=$beta --server_learning_rate=$slr --experiment_name=synthetic${alpha}_${bd}_cl${clients}_importance${beta}_slr${slr}				
				done
			done
		done
	done
done


 