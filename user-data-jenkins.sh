#!/bin/bash

git clone https://mustafa_fns@bitbucket.org/finspire-tech/restore-jenkins-on-aws.git
cd /restore-jenkins-on-aws


#change mod of the file to be able to run as a script
chmod 766 install_docker_and_docker_compose.sh

#install docker and docker-compose with downloaded script
sudo ./install_docker_and_docker_compose.sh

#create infrastructure with docker-compose
cd /restore-jenkins-on-aws/jenkins
sudo docker-compose up -d

#stop jenkins container before restore
sudo docker stop jenkins

#install aws cli
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
unzip awscliv2.zip 
sudo ./aws/install
sudo rm awscliv2.zip 

# Do not forget to change s3 bucket name as it is unique
sudo aws s3 sync s3://jenkins-daily-backup-files /var/lib/docker/volumes/jenkins_jenkins-data/_data/

#start jenkins container after restore
sudo docker start jenkins