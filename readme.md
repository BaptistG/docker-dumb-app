To test locally:

docker build -t dumb_app .

docker run -p 3000:8080 dumb_app

Don't forget to clean up after yourself by running (unless you have other containers you want to keep):
docker container prune

Script total:
#!/bin/bash
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

git clone https://github.com/padok-team/docker-dumb-app.git
cd docker-dumb-app/
sudo docker build -t dumb_app .

sudo docker run -p 3000:8080 dumb_app