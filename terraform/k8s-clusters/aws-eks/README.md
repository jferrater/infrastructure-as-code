# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster), containing
Terraform configuration files to provision an EKS cluster on AWS.

# Quick Start
1. Install terraform and add to PATH
    `make install`
2. Runs `terraform init`
    `make init`
3. Runs `terraform plan`
    `make plan`
4. Runs `terraform apply` and deploys to AWS
    `make deploy`