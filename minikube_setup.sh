#!/bin/bash
sudo apt-get update; sudo apt-get -y install docker.io;
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"; \
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"; \
echo "$(<kubectl.sha256) kubectl" | sha256sum --check; \
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64; \
chmod +x minikube; \
sudo cp minikube /usr/local/bin && rm minikube
sudo groupadd docker; sudo usermod -aG docker $USER
systemctl start docker.service
