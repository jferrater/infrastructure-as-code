## This folder will contain the terraform manifests for the Kubernetes
## Clusters. There will be four K8s clusters (Dev, QA, Stage and Prod) environments

### Quick start
1. ``terraform init``
2. ``terraform plan``
3. ``terraform apply``
4. ``terraform output kubeconfig > $(HOME)/.kube/config``
5. Install ``aws-iam-authenticator`` to be able to authenticate to the cluster
    - https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html

6. ``kubectl get nodes``

### Get AWS account info using aws cli
``aws sts get-caller-identity --query Account --output text``

## Creating an Amazon EKS cluster
### Prerequisites:
- VPC - https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
- Security Group - https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html
- IAM roles
