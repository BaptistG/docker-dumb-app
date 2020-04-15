#!/bin/bash

# Get the variables
source config.sh

# Copy setup script to remote server 
scp -i $private_key_path setup.sh ubuntu@$instance_public_address:~/setup.sh

# Run setup script on the remote server
ssh -i $private_key_path ubuntu@$instance_public_address sh setup.sh $1