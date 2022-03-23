#!/bin/sh
sudo yum -y update

if ! type "docker" > /dev/null; then
  echo "Installing Docker and docker-compose"
  sudo yum update -y
  sudo yum install -y docker
  sudo systemctl start docker
  sudo usermod -a -G docker ec2-user
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

fi

# get ips | search inet addr: | split on : get 2nd field | print out
ADDRESS=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
# if we have an emtpy address
if [[ -z "${ADDRESS}"]]; then
  # some prints won't have the addr portion, do a last ditch effort to get the ip
  # get ips | search inet | get first line | trim string | split on ' ' get the 2nd field | print out
  ADDRESS=$(ifconfig eth0 | grep 'inet' | awk 'NR == 1' | awk '{$1=$1};1' | cut -d ' ' -f 2 | awk '{ print $1}')
fi
docker swarm init --advertise-addr="$ADDRESS"

if ! type "git" > /dev/null; then
  echo "Installing Git"
  sudo yum -y install git
fi

DIRECTORY="dockerprom"
if [ -d "$DIRECTORY" ]; then
  rm -rf "$DIRECTORY"
fi
echo "Cloning Project"
git clone https://github.com/ritubajaj89/dockprom.git
cd "$DIRECTORY"

#echo "Making Utility scripts executable"
#chmod +x ./util/*.sh

sed 

echo "Starting Application"
#docker stack deploy -c docker-compose.yml prom
sudo docker-compose up -d

echo "Waiting 5 seconds for services to come up"
sleep 5

while docker service ls | grep "0/1";  do sleep 3; echo "Waiting..."; done;

echo "You can now access your Grafana dashboard at http://$ADDRESS:3000"
