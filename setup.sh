#!/bin/bash

# Download an install docker (straight from docker website)
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Build image from dockerfile
sudo docker build -t dumb_app .

# Launch container and map port 3000 on host machine to port 8080 in container)
# Running a detached container so that everything works when the user disconnects from the server
sudo docker run -p 3000:8080 -d dumb_app