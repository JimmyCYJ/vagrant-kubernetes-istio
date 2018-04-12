#!/bin/bash

# Install vagrant.
echo "Install vagrant"
sudo apt-get --quiet -y update
sudo apt-get --quiet -y install vagrant 

# Install virtualbox.
echo "Install virtualbox"
sudo apt-get install --quiet -y libpng16-16 libssl1.0.2 libvpx4
curl -L https://download.virtualbox.org/virtualbox/5.2.8/virtualbox-5.2_5.2.8-121009~Ubuntu~xenial_amd64.deb --output virtualbox.deb
sudo dpkg -i virtualbox.deb -y
sudo apt-get install -f

# Setup vagrant.
echo "Setup vagrant"
vagrant destroy
vagrant up --provider virtualbox
vagrant ssh -c "echo export HUB=10.10.0.2:5000 >> ~/.bashrc"
vagrant ssh -c "echo export TAG=latest >> ~/.bashrc"
vagrant ssh -c "source ~/.bashrc"

# Adding insecure registry on VM.
echo "Adding insecure registry to docker daemon in vagrant vm..."
vagrant ssh -c "sudo sed -i 's/ExecStart=\/usr\/bin\/dockerd -H fd:\/\//ExecStart=\/usr\/bin\/dockerd -H fd:\/\/ --insecure-registry 10.10.0.2:5000/' /lib/systemd/system/docker.service"
vagrant ssh -c "sudo systemctl daemon-reload"
vagrant ssh -c "sudo systemctl restart docker"

# Setting up kubernetest Cluster on VM for Istio Tests.
echo "Adding priviledges to kubernetes cluster..."
vagrant ssh -c "sudo sed -i 's/ExecStart=\/usr\/bin\/hyperkube kubelet/ExecStart=\/usr\/bin\/hyperkube kubelet --allow-privileged=true/' /etc/systemd/system/kubelet.service"
vagrant ssh -c "sudo systemctl daemon-reload"
vagrant ssh -c "sudo systemctl stop kubelet"
vagrant ssh -c "sudo systemctl restart kubelet.service"
vagrant ssh -c "sudo sed -i 's/ExecStart=\/usr\/bin\/hyperkube apiserver/ExecStart=\/usr\/bin\/hyperkube apiserver --allow-privileged=true/' /etc/systemd/system/kube-apiserver.service"
vagrant ssh -c "sudo sed -i 's/--admission-control=AlwaysAdmit,ServiceAccount/--admission-control=AlwaysAdmit,NamespaceLifecycle,LimitRanger,ServiceAccount,PersistentVolumeLabel,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota/'  /etc/systemd/system/kube-apiserver.service"
vagrant ssh -c "sudo systemctl daemon-reload"
vagrant ssh -c "sudo systemctl stop kube-apiserver"
vagrant ssh -c "sudo systemctl restart kube-apiserver"
vagrant reload
vagrant ssh -c "kubectl get pods -n kube-system"

# Setting up linux host to talk to kubernetest cluster on Vagrant VM.
echo "your old ~/.kube/config file can be found at ~/.kube/config_old"
cp ~/.kube/config ~/.kube/config_old
vagrant ssh -c "cp /etc/kubeconfig.yml ~/.kube/config"
vagrant ssh -c "cat ~/.kube/config" > ~/.kube/config
sed -i '/Connection to 127.0.0.1 closed/d' ~/.kube/config
