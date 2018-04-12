#!/bin/bash
HUB=10.10.0.2:5000 
TAG=latest 
cd $ISTIO/istio
make docker HUB=10.10.0.2:5000 TAG=latest
make push HUB=10.10.0.2:5000 TAG=latest
echo "Check images present in repositories"
curl 10.10.0.2:5000/v2/_catalog -v


