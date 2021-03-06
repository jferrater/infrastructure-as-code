# Kubernetes Clusters in AWS
Deploys four Kubernetes Clusters (dev, qa, staging, prod) in AWS EKS.   

## Prerequisites
- AWS account
- ``aws-iam.authenticator``
    - https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html

## Quick start
1. Initialize environment (Valid values: dev, qa, staging, prod)
```bash
make init ENVIRONMENT=qa
```
2. Check terraform plan of an environment.
```bash
make plan ENVIRONMENT=qa
```
3. Deploy the environment to AWS EKS. This generates a kube config file in the environment directory.
```bash
make deploy ENVIRONMENT=qa
```
4. Set the KUBECONFIG environment variable using the kube config file in previous step.
```bash
export KUBECONFIG=${PWD}/environments/qa/kubeconfig_qa-cluster
```

## Deleting the cluster
```bash
make destroy ENVIRONMENT=qa
```
