
# Push Images from Host to VM and Run Test Command on VM

This sets up your local linux box to run tests on a kubernetes cluster on vagrant VM. 

# Prereqs:
Please follow Istio developer guide to set up environment on both host machine and VM. [environment setup](https://github.com/istio/istio/blob/master/DEV-GUIDE.md#setting-up-environment-variables) 


# Setup on Host Machine
1) Create a vagrant directory inside your istio repository.

```bash
source ~/.profile
cd $ISTIO
mkdir -p vagrant
cd vagrant
```

2) Clone this repository in this folder

```bash
git clone https://github.com/JimmyCYJ/vagrant-kubernetes-istio.git
```

3) Setup Vagrant Environment
Script will prompt for sudo password.

```bash
cd $ISTIO/vagrant/vagrant-kubernetes-istio/RunTestOnVM
chmod +x host_setup.sh
sh host_setup.sh
```

```bash
sudo vagrant ssh
cd /vagrant-kubernetes-istio
chmod +x RunTestOnVm/vm_setup.sh
sh RunTestOnVm/vm_setup.sh
exit
```

4) Now you are ready to run tests!

Push images from your local dev environment to local registry on vagrant vm:
```bash
cd $ISTIO/vagrant/vagrant-kubernetes-istio/RunTestOnVM
chmod +x test_setup.sh
sh test_setup.sh
```
After this you can run all the e2e tests using normal make commands. Ex:
```bash
sudo vagrant ssh
cd $ISTIO/istio
make e2e_simple E2E_ARGS="--use_local_cluster"
```
You can keep repeating this step if you made any local changes and want to run e2e tests again.
Add E2E_ARGS="--use_local_cluster" to all your e2e tests as tests are we are running a local cluster.

**Steps 1,2 and 3 are supposed to be one time step unless you want to remove vagrant environment from your machine.**

# Cleanup
1) Cleanup test environment
```bash
cd $ISTIO/vagrant/
vagrant destroy
```

2) Cleanup vagrant environment
This is necessary if you want to remove vagrant VM setup from your host and want to bring it back to original state
```bash
cd $ISTIO/vagrant/vagrant-kubernetes-istio/RunTestOnVM
chmod +x cleanup_linux_host.sh
sh cleanup_linux_host.sh
```
