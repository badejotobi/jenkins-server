#!/bin/bash
# Install Apache Web Server and PHP
#sudo amazon-linux-extras install java-openjdk17
#Install the Repo and Key, and Then Install Jenkins
#1.	Install wget:
sudo yum install java-17-amazon-corretto-devel -y
sudo yum install -y wget
#Download the repo:
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
#Import the required key:
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
#Install Jenkins:
sudo yum install -y jenkins
#Reload systemd files:
sudo systemctl daemon-reload
#Enable Jenkins:
sudo systemctl enable jenkins
#Start Jenkins:
sudo systemctl start jenkins