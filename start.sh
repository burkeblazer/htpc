#!/bin/bash

apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
curl -sSL https://get.docker.com | sh

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
