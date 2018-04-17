#!/usr/bin/env bash

# Set up Istio
echo "export GOPATH=/home/vagrant/go" >> $HOME/.profile
echo "export PATH=$PATH:$GOPATH/bin" >> $HOME/.profile
echo "export ISTIO=$GOPATH/src/istio.io" >> $HOME/.profile
echo "export HUB=localhost:5000" >> $HOME/.profile
echo "export TAG=latest" >> $HOME/.profile
source $HOME/.profile

mkdir -p $ISTIO

# Copy kube config
echo "Copy kube config file to ~/.kube/config"
mkdir $HOME/.kube
cp /etc/kubeconfig.yml $HOME/.kube/config

# Deploy kubernetes local docker registry."
echo "Deploy kubernetes local docker registry."
kubectl apply -f $ISTIO/istio/tests/util/localregistry/localregistry.yaml
