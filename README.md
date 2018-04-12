# vagrant-kubernetes-istio

Set up Kubernetes on VM with vagrant for Istio testing.

# [RunTestOnHost](https://github.com/JimmyCYJ/vagrant-kubernetes-istio/tree/master/RunTestOnHost "RunTestOnHost")

 - Build Istio docker images on host machine.
 - Set up private docker registry in Kubernetes on VM.
 - Push images from host to VM. The images are stored in private docker registry
 - Run Istio e2e tests command on Host. The test environment is deployed in Kubernetes on VM, and test result is returned to host.


# [RunTestOnVm](https://github.com/JimmyCYJ/vagrant-kubernetes-istio/tree/master/RunTestOnVm "RunTestOnVm")

 - Build Istio docker images on host machine.
 - Set up private docker registry in Kubernetes on VM.
 - Push images from host to VM. The images are stored in private docker registry
 - Run Istio e2e tests command on VM. The test result is returned to VM.

