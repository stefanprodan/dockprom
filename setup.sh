#!/bin/bash
echo 'Welcome to the Dockprom Setup'
echo ''

echo 'Enter the desired Username for the configuration'
read USERNAME 
echo 'Enter the desired Password for the configuration'
read PASSWORD 

export ADMIN_USER $USERNAME            #Set the username
export ADMIN_PASSWORD $PASSWORD        #Set the password

cd /tmp

git clone https://github.com/MiguelNdeCarvalho/dockprom.git
cd dockprom
docker-compose up -d

