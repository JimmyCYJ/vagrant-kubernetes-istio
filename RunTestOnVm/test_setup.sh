#!/bin/bash

# Setup HUB and TAG to talk to insecure local registry on VM.
HUB=10.10.0.2:5000 
TAG=latest 

# Make and Push images to insecure local registry on VM.
cd $ISTIO/istio
echo "Build docker images."
make docker HUB=10.10.0.2:5000 TAG=latest
echo "Push docker images to local registry in VM."
make push HUB=10.10.0.2:5000 TAG=latest

# Verify images are pushed in repository.
echo "Check images present in repositories"
curl 10.10.0.2:5000/v2/_catalog -v


