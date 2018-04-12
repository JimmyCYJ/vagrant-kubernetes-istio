# Push images from host to VM and run test command on VM

Assume that Istio developer has followed this [environment setup](https://github.com/istio/istio/blob/master/DEV-GUIDE.md#setting-up-environment-variables)

This sets up your local linux box to run tests on a kubernetes cluster on vagrant VM.

# Benefits:
1) Setup the vagrant VM Environment once and then using your normal make e2e_all commands from your development environment you can run tests on vagrant VM.
2) No need to worry about kubernetes cluster setup.. scripts will take care of it for you
3) TODO: Debug tests right from your development environment.

# Prereqs:
Nothing :)
Well, not really, you need to have Istio Dev Environment setup on your box!
Refer: https://github.com/istio/istio/blob/master/DEV-GUIDE.md for that.

# Setup
1) Create a vagrant directory inside your istio repository.

```bash
cd $ISTIO/istio
mkdir -p vagrant
cd vagrant
```

2) Clone this repository in this folder

```bash
git clone https://github.com/JimmyCYJ/vagrant-kubernetes-istio.git
```

3) Setup Vagrant Environment

```bash
cd RunTestOnHost
sh startup_linux_host.sh
```

4) Now you are ready to run tests!

Push images from your local dev environment to local registry on vagrant vm:
```bash
sh test_setup.sh
```
After this you can run all the e2e tests using normal make commands. Ex:
```bash
make simple_e2e
```
You can keep repeating this step if you made any local changes and want to run e2e tests again.

Steps 1,2 and 3 are supposed to be one time step unless you want to remove vagrant environment from your machine.

# Cleanup
1) Cleanup test environment
```bash
cd $ISTIO/istio/vagrant/RunTestOnHost
vagrant destroy
```

2) Cleanup vagrant environment
This is necessary if you want to remove vagrant VM setup from your host and want to bring it back to original state
```bash
cd $ISTIO/istio/vagrant/RunTestOnHost
sh cleanup_linux_host.sh
```

# Modify vagrant to run in non-sudo mode
By default, vagrant is running in sudo mode, and that consumes root partition.
If root partition is limited and we want to run it in non-sudo mode, then we can make following changes.
Assume we are in $ISTIO/vagrant path, we can run this command to find all vagrant config files.
```bash
$ls -al .vagrant/
```
For all files/folders that are owned by root, we can change its owner and group to the current user and user's group.
```bash
sudo chown $USER:$(id -gn) .vagrant/machines/
sudo chown $USER:$(id -gn) .vagrant/machines/default/
sudo chown $USER:$(id -gn) .vagrant/machines/default/virtualbox/
sudo chown $USER:$(id -gn) .vagrant/machines/default/virtualbox/vagrant_cwd
```
Next time when we are going to bring up VM with vagrant, just use
```bash
vagrant up --provider virtualbox
```
Similarly, to ssh to VM, just run
```
vagrant ssh
```
