#!/bin/bash

# Exit on any error
set -e

cd ./remote-state-setup

# Apply resources related to the remote backend state file
terraform init  # Initialize the directory
terraform apply -auto-approve


# Navigate back to the original directory
cd ../

# Apply resources in the first directory
terraform init  # Initialize the directory
terraform apply -auto-approve

