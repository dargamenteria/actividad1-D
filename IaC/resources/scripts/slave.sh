#!/bin/bash
#
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list >/dev/null
sudo apt-get update
sudo apt install -y ca-certificates curl python3-flask junit flake8 python3-flake8 bandit python3-bandit python3-pip openjdk-17-jdk

