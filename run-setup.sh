#!/bin/bash
# cd terraform
# terraform init
# terraform plan
# terraform apply

cd ../ansible
ansible-playbook -i inventory --key-file keyfile.pem webserver.yml

echo "Setup complete."
