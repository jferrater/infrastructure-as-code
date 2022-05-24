Ingress and Ingress controller
==============================
Deploy nginx Ingress controller using NodePort
```bash
kubectl apply -f ingress-nginx-deploy.yaml
kubectl get svc,deploy,pod -o wide --namespace ingress-nginx
```
Additionally deploy nginx ingress controller as DaemonSet on all worker nodes with hostNetwork parameter set to true
```bash
kubectl apply -f ingress-nginx-ds.yaml
kubectl get ds,pod -o wide --namespace ingress-nginx
```
Deploy demo app and ingress
```bash
kubectl apply -f ingress/demo-app.yaml
kubectl apply -f ingress/demo-ingress.yaml
kubectl get ing,svc,ep,deploy,pod -o wide
```
Verify that it works by using curl or browser
```bash
curl -H Host:example.com http://10.1.3.201/v1
curl -H Host:example.com https://10.1.3.204/v1 --insecure
```

more info:
- https://kubernetes.io/docs/concepts/services-networking/ingress/
- https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
- https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal