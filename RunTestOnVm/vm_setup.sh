#!/usr/bin/env bash

mkdir -p $ISTIO
cp rf /istio.io/istio /home/vagrant/go/src/istio.io 

# Copy kube config
echo "Copy kube config file to ~/.kube/config"
mkdir $HOME/.kube
cp /etc/kubeconfig.yml $HOME/.kube/config

# Deploy kubernetes local docker registry."
echo "Deploy kubernetes local docker registry."
kubectl apply -f $ISTIO/istio/tests/util/localregistry/localregistry.yaml
