#!/bin/bash               
sudo yum update -y               
sudo amazon-linux-extras install docker -y               
sudo service docker start               
sudo usermod -a -G docker ec2-user               
sudo systemctl enable docker              
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose               
sudo chmod +x /usr/local/bin/docker-compose
sudo yum install git -y


