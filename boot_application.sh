#!/bin/bash -x
rm -rf target/RestMessageAPI.jar*
sudo mvn clean install
sudo docker container ps -a | grep "api_app" | awk {'print $1'} | xargs sudo docker container rm
sudo lsof -ti tcp:80 | xargs sudo kill -9
sudo lsof -ti tcp:8080 | xargs sudo kill -9
sudo lsof -ti tcp:5432 | xargs sudo kill -9
sudo iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo docker build -f Dockerfile -t api_app .
sudo docker-compose up
