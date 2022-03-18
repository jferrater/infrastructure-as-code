# infrastructure-as-code


# Kubernetes Clusters in AWS
Deploys four Kubernetes Clusters (dev, qa, staging, prod) in AWS EKS.   

## Prerequisites
- AWS account
- ``aws-iam.authenticator``
    - https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html

## Quick start
1. `cd infra/k8s-clusters`
2. Initialize environment (Valid values: dev, qa, staging, prod)
```bash
make init ENVIRONMENT=qa
```
3. Check terraform plan of an environment.
```bash
make plan ENVIRONMENT=qa
```
4. Deploy the environment to AWS EKS. This generates a kube config file in the environment directory.
```bash
make deploy ENVIRONMENT=qa
```
5. Set the KUBECONFIG environment variable using the kube config file in previous step.
```bash
export KUBECONFIG=${PWD}/environments/qa/kubeconfig_qa-cluster
```

## Deleting the cluster
```bash
make destroy ENVIRONMENT=qa
```
