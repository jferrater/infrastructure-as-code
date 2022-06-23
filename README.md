All about infrastructure
========================
Dumping my brain and learnings about software infrastructure here in this repo.

Cheat Sheet
===========
more info: https://kubernetes.io/docs/reference/kubectl/cheatsheet/


kubectl autocomplete
--------------------
```bash
source <(kubectl completion bash) && echo "source <(kubectl completion bash)" >> ~/.bashrc
```


remove all evicted pods
-----------------------
```bash
kubectl get pod | grep Evicted | awk '{print $1}' | xargs kubectl delete pod
```


merge two kubeconfig files
--------------------------
```bash
KUBECONFIG=~/.kube/config:~/.kube/config-2 kubectl config view --flatten > .kube/config-merged
```


remove namespace that stuck in the terminating state
----------------------------------------------------
```bash
kubectl get namespace "stucked-namespace" -o json \
  | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
  | kubectl replace --raw /api/v1/namespaces/stucked-namespace/finalize -f -
```


netcat as a port scanner
------------------------
```bash
netcat -vznC -w2 127.0.0.1 1-65535 2>&1 | grep succeeded!
```


list iptables
-------------
```bash
sudo iptables -L -t nat
```


find a file in a user home directory
```bash
find $HOME -name fileName*
grep -rnw $HOME -e 'fileContent'
```

tail pd logs using label
------------------------
```bash
kubectl logs -l app=demo --follow --tail 5
```
get logs of the terminated pod
------------------------------
kubectl logs -l app=demo --previous

Kubernetes Service
------------------
- targetPort - the name of the deployment port; use name so that Service knows where to route the request
- clusterIp is None - headless service; use in StatefulSet
- nslookup service-name ; nslookup servicename.default.svc.cluster.local

Pod Termination
---------------

Since Pods represent processes running on your cluster, Kubernetes provides for graceful termination when Pods are no longer needed. Kubernetes implements graceful termination by applying a default grace period of 30 seconds from the time that you issue a termination request. A typical Pod termination in Kubernetes involves the following steps:

    - You send a command or API call to terminate the Pod.
    - Kubernetes updates the Pod status to reflect the time after which the Pod is to be considered "dead" (the time of the termination request plus the grace period).
    - Kubernetes marks the Pod state as "Terminating" and stops sending traffic to the Pod.
    - Kubernetes send a TERM signal to the Pod, indicating that the Pod should shut down.
    - When the grace period expires, Kubernetes issues a SIGKILL to any processes still running in the Pod.
    - Kubernetes removes the Pod from the API server on the Kubernetes Master.

    Note: The grace period is configurable; you can set your own grace period when interacting with the cluster to request termination, such as using the kubectl delete command. See the Terminating a Pod tutorial for more information.
