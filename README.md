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