#!/bin/bash -x
sudo hostname rest-api-docker-demo
sudo echo "rest-api-docker-demo" | sudo tee /etc/hostname
sudo echo "127.0.1.1     rest-api-docker-demo" | sudo tee -a /etc/hosts

sudo apt-get update;
sudo apt-get install curl --assume-yes;
sudo apt-get install wget --assume-yes;
sudo apt-get install htop --assume-yes;
sudo apt-get install vim --assume-yes;
sudo apt-get install git --assume-yes;

echo "## Installing Java"
sudo apt-get install default-jre --assume-yes;
sudo add-apt-repository ppa:webupd8team/java --assume-yes;
sudo apt-get update;
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install oracle-java8-installer --assume-yes;
$echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment
source /etc/environment;



echo "## Installing Maven"
sudo apt-get install maven --assume-yes;



echo "## Installing Docker"
sudo apt-get update;
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common --assume-yes;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository --assume-yes \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update;
sudo apt-get install docker-ce --assume-yes;
apt-cache madison docker-ce;


echo "## Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose;


echo "## Code setup"
cd /opt
git clone https://github.com/hkhajgiwale/spring-boot-postgres-rest-api-docker.git
cd spring-boot-postgres-rest-api-docker
chmod +x boot_application.sh
./boot_application.sh