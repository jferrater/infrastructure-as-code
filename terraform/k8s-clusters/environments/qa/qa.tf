module "qa-k8s-cluster" {
  source = "../../aws-eks"

  environment = "qa"
}