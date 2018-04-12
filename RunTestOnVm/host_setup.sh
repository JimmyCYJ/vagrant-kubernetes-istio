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
vagrant ssh -c "echo export HUB=localhost:5000 >> ~/.bashrc"
vagrant ssh -c "echo export TAG=latest >> ~/.bashrc"
vagrant ssh -c "source ~/.bashrc"

# Setting up host to talk to insecure registry on VM.
echo "Adding insecure registry to docker daemon in host vm..."
echo "You old docker daemon file can be found at /lib/systemd/system/docker.service_old"
sudo cp /lib/systemd/system/docker.service /lib/systemd/system/docker.service_old
sudo sed -i 's/ExecStart=\/usr\/bin\/dockerd -H fd:\/\//ExecStart=\/usr\/bin\/dockerd -H fd:\/\/ --insecure-registry 10.10.0.2:5000/' /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo systemctl restart docker

# Set route rule to access VM
echo "Set route rule to access VM"
sudo ip route add 10.0.0.0/24 via 10.10.0.2
