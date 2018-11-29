#!/bin/bash

apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
curl -sSL https://get.docker.com | sh
usermod -aG docker pi

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

#Make sure docker group was created and that pi belongs to it
#sudo - su
#Run id
#Edit env variables
#vi ~/.bashrc
#export PUID=1000
#export PGID=140
#export TZ="America/New_York"
#export USERDIR="/home/pi"
#export MYSQL_ROOT_PASSWORD="oncechildrenporchweiner"

#After you do the above you can uncomment the docker-compose and run that
#Recommend putting that command in your bashrc with an alias
#Also, edit the actual docker-compose.yml file in /home/pi/docker so that it fits your needs
mkdir /home/pi/docker
cd /home/pi/docker
cp /home/pi/git/htpc/docker-compose.yml .
#docker-compose -f ~/docker/docker-compose.yml up -d
