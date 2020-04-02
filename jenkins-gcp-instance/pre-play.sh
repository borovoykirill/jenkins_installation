#!/bin/bash

# Create VMs

cd Terraform && terraform init && terraform apply <<< yes

# Get IPs
for instance_name in 'front' 'jenkins'; do
	echo "$instance_name external IP: $(gcloud compute instances list | grep $instance_name | sed "s/  */ /g" | cut -d' ' -f5)"
done

echo -e "now run:\n$ ansible-playbook -i inventory.prod playbook.yml --become"
