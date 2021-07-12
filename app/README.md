## Prerequisites
    - KUBECONFIG environment variable

## Publish sample app to Docker Hub
1. Build and tag the image
```bash
docker build -t jmferrater/hello-jolly-app:0.1 .
```
2. Publish image to the Docker Hub
```bash
docker push jmferrater/hello-jolly-app:0.1
```

## Deploying the app to Kubernetes Cluster
1. Deploy <br>
```bash
 kubectl apply -f k8s-manifests
```
2. Check if the pods are ready <br>
```bash
kubectl get pods
```
3. Verify if the app is accessible <br>
 ```bash
 curl -i `kubectl get services hello-jolly --output jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
 ```

## Deleting Kubernetes resources
```bash
kubectl delete -f k8s-manifests
```