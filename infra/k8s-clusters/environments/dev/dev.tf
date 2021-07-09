module "dev-k8s-cluster" {
  source = "../../aws-eks"

  environment = "dev"
}