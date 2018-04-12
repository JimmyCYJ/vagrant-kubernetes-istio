#!/usr/bin/env bash

# Install golang
echo "Install go"
sudo curl -O https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
sudo tar -xvf go1.10.1.linux-amd64.tar.gz
sudo mv go /usr/local

sudo apt-get install socat

# Install git
echo "Install git"
sudo apt-get install git

# Set up Istio
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.profile
echo "export GOPATH=~/go" >> $HOME/.profile
echo "export PATH=$PATH:$GOPATH/bin" >> $HOME/.profile
echo "export ISTIO=$GOPATH/src/istio.io" >> $HOME/.profile
echo "export HUB=localhost:5000" >> $HOME/.profile
echo "export TAG=latest" >> $HOME/.profile
source $HOME/.profile
mkdir -p $ISTIO
cd $ISTIO
git clone “https://github.com/istio/istio.git”

# Copy kube config
echo "Copy kube config file to ~/.kube/config"
cp /etc/kubeconfig.yml $HOME/.kube/config
