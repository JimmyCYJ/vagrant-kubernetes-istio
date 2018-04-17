#!/usr/bin/env bash

sudo apt-get update
sudo apt-get --quiet -y install socat

# Install git
echo "Install git"
sudo apt-get --quiet -y install git

# Set up Istio
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.profile
echo "export GOPATH=~/go" >> $HOME/.profile
echo "export PATH=$PATH:$GOPATH/bin" >> $HOME/.profile
echo "export ISTIO=/istio" >> $HOME/.profile
echo "export HUB=localhost:5000" >> $HOME/.profile
echo "export TAG=latest" >> $HOME/.profile
source $HOME/.profile

# Setting up kubernetest Cluster on VM for Istio Tests.
echo "Adding priviledges to kubernetes cluster..."
sudo sed -i 's/ExecStart=\/usr\/bin\/hyperkube kubelet/ExecStart=\/usr\/bin\/hyperkube kubelet --allow-privileged=true/' /etc/systemd/system/kubelet.service
sudo systemctl daemon-reload
sudo systemctl stop kubelet
sudo systemctl restart kubelet.service
sudo sed -i 's/ExecStart=\/usr\/bin\/hyperkube apiserver/ExecStart=\/usr\/bin\/hyperkube apiserver --allow-privileged=true/' /etc/systemd/system/kube-apiserver.service
sudo sed -i 's/--admission-control=AlwaysAdmit,ServiceAccount/--admission-control=AlwaysAdmit,NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota/'  /etc/systemd/system/kube-apiserver.service
sudo systemctl daemon-reload
sudo systemctl stop kube-apiserver
sudo systemctl restart kube-apiserver
kubectl get pods -n kube-system

# Copy kube config
echo "Copy kube config file to ~/.kube/config"
mkdir $HOME/.kube
cp /etc/kubeconfig.yml $HOME/.kube/config
