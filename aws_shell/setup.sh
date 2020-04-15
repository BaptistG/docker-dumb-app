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

# Remove previous version of git repo if it exists
if [ -d docker-dumb-app ]; then rm -rf docker-dumb-app; fi

# Clone the remote git repo
git clone -b $1 https://github.com/BaptistG/docker-dumb-app.git
cd docker-dumb-app

# Stop all running docker containers
sudo docker ps -q --filter "name=dumb_app" | grep -q . && sudo docker stop dumb_app && sudo docker rm -fv dumb_app


# Remove all images (we don't need old images and they'll fill the disk space until the disk is full)
sudo docker image prune -f

# Build image from dockerfile, you should usually tag the image because if you dont it'll automatically use latest and when you build again it'll overwrite that tag
# This means you won't be able to use the previous image
sudo docker build -t dumb_app .

# Launch container and map port 3000 on host machine to port 8080 in container)
# Running a detached container so that everything works when the user disconnects from the server
sudo docker run -d -p 3000:8080 --name=dumb_app dumb_app