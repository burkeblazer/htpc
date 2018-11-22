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
chown pi:pi -R /home/pi/git/compose
cd /home/pi/git/compose
git checkout remotes/origin/release
docker build -t docker-compose:armhf -f Dockerfile.armhf .
docker run --rm --entrypoint="script/build/linux-entrypoint" -v $(pwd)/dist:/code/dist -v $(pwd)/.git:/code/.git "docker-compose:armhf"
cp dist/docker-compose-Linux-armv7l /usr/local/bin/docker-compose
chown root:root /usr/local/bin/docker-compose
chmod 0755 /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
