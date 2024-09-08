#!/bin/bash

# Exit on any error
set -e

# Destroy resources in the first directory
cd ~/partionA/terraform_final_boss
terraform destroy -auto-approve

# Destroy resources in the second directory related to the remote backend state file
cd ./remote-state-setup
terraform destroy -auto-approve
