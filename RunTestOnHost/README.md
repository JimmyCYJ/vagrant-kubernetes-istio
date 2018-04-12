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
Script will prompt for sudo password.

```bash
cd vagrant-kubernetes-istio/RunTestOnHost
sh startup_linux_host.sh
```

4) Now you are ready to run tests!

Push images from your local dev environment to local registry on vagrant vm:
```bash
cd $ISTIO/istio/vagrant-kubernetes-istio/RunTestOnHost
sh test_setup.sh
```
After this you can run all the e2e tests using normal make commands. Ex:
```bash
cd $ISTIO/istio
make e2e_simple
```
You can keep repeating this step if you made any local changes and want to run e2e tests again.

**Steps 1,2 and 3 are supposed to be one time step unless you want to remove vagrant environment from your machine.**

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

