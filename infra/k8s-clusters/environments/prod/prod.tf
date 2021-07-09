module "prod-k8s-cluster" {
  source = "../../aws-eks"

  environment = "prod"
}