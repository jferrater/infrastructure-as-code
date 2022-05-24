Creating a Cluster with kubeadm
===============================

Docker installation
-------------------
```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && apt-cache madison docker-ce
sudo apt-get install -y docker-ce=5:20.10.8~3-0~ubuntu-focal && sudo apt-mark hold docker-ce
sudo usermod -aG docker nobleprog
```
Refer to: https://kubernetes.io/docs/setup/production-environment/container-runtimes/


Kubernetes Installation
-----------------------
```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https bash-completion curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update && apt-cache madison kubeadm
sudo apt-get install -y kubeadm=1.22.6-00 kubectl=1.22.6-00 kubelet=1.22.6-00
sudo apt-mark hold kubeadm kubectl kubelet
source <(kubectl completion bash) && echo "source <(kubectl completion bash)" >> ~/.bashrc
source <(kubeadm completion bash) && echo "source <(kubeadm completion bash)" >> ~/.bashrc
```
Refer to: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

Cluster initialization
----------------------
Initialize the control plane node on master-1 and configure kubectl
```bash
sudo kubeadm init
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
Start pod network (Weave Net in this case)
```bash
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```
Generate a new join command (if you lost the default one printed during the initialisation) and run it on all worker nodes
```bash
kubeadm token create --print-join-command 
ssh worker-1
sudo kubeadm join --token bf37a8...
```
Check the status of all nodes and all pods
```bash
kubectl get nodes,pod -o wide --all-namespaces
```
More info:
- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
- https://kubernetes.io/docs/concepts/cluster-administration/addons/

Runninng apps on the master node (not for production)
-----------------------------------------------------
optionally allow pods to be scheduled on the master node (useful if you need a single-node Kubernetes cluster)
```bash
kubectl taint nodes --all node-role.kubernetes.io/master-
```
or bring back the default taint
```bash
kubectl taint nodes master node-role.kubernetes.io/master:NoSchedule
```
Changing Docker cgroup driver
-----------------------------
```bash
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
sudo systemctl restart docker.service
```
Cloud-Native Storage - Rook.io
------------------------------
The commands below will work only if you have a cluster with at least three worker nodes. Each of them needs to have at least one unused disk.
```bash
git clone --single-branch --branch v1.7.8 https://github.com/rook/rook.git
cd rook/cluster/examples/kubernetes/ceph
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
kubectl create -f cluster.yaml
kubectl create -f csi/rbd/storageclass.yaml
watch -n1 kubectl get pod --namespace rook-ceph -o wide
```
Starting all pods in the rook-ceph namespace will take some time. When they reach the ready state, you can create a test PVC and a pod that will use it.
```bash
kubectl apply -f csi/rbd/pvc.yaml -f csi/rbd/pod.yaml
kubectl get pod --namespace rook-ceph -o wide
```