module "staging-k8s-cluster" {
  source = "../../aws-eks"

  environment = "staging"
}