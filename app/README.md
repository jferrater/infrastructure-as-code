## Prerequisites
    - KUBECONFIG environment variable

## Publish sample app to Docker Hub
1. `docker build -t jmferrater/hello-jolly-app:0.1 .`
2. `docker push jmferrater/hello-jolly-app:0.1`

## Deploying the app to Kubernetes Cluster
`kubectl apply -f k8s-manifests`

## Deleting Kubernetes resources
`kubectl delete -f k8s-manifests`