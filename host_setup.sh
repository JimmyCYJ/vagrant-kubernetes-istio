#!/bin/bash

# Install vagrant
echo "Install vagrant"
sudo apt-get install vagrant -y

# Install virtualbox
echo "Install virtualbox"
sudo apt-get install -y libpng16-16 libssl1.0.2 libvpx4
curl -L https://download.virtualbox.org/virtualbox/5.2.8/virtualbox-5.2_5.2.8-121009~Ubuntu~xenial_amd64.deb --output virtualbox.deb
sudo dpkg -i virtualbox.deb -y
sudo apt-get install -f

# Create a directory for vagrant VM
echo "Create a directory for vagrant VM"
cd $ISTIO
mkdir flix-tech
cd flix-tech
vagrant init flixtech/kubernetes

# Set route rule to access VM
echo "Set route rule to access VM"
sudo ip route add 10.0.0.0/24 via 10.10.0.2
