#!/bin/bash

apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y install git vim apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=armhf] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce

git clone https://github.com/docker/compose.git /home/pi/git/compose
cd /home/pi/git/compose
git checkout release
