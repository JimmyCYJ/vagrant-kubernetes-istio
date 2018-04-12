# vagrant-kubernetes-istio

Set up Kubernetes on VM with vagrant for Istio testing.

# [RunTestOnHost](https://github.com/JimmyCYJ/vagrant-kubernetes-istio/tree/master/RunTestOnHost "RunTestOnHost")

```mermaid
sequenceDiagram
Host ->> Host: Build Istio docker images
VM ->> VM: Set up private docker registry in Kubernetes
Host ->> VM: Push images to private docker registry
Host ->> Host: Run Istio e2e tests command on Host

Note right of Host: The test environment is<br/>deployed in Kubernetes and<br/> test result is<br/>returned to Host.
```

# [RunTestOnVm](https://github.com/JimmyCYJ/vagrant-kubernetes-istio/tree/master/RunTestOnVm "RunTestOnVm")

```mermaid
sequenceDiagram
Host ->> Host: Build Istio docker images
VM ->> VM: Set up private docker registry in Kubernetes
Host ->> VM: Push images to private docker registry
VM ->> VM: Run Istio e2e tests command on VM
```

