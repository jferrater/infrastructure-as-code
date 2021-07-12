module "dev-k8s-cluster" {
  source = "../../aws-eks"

  environment = "dev"

  worker_groups = [
    {
      name                          = "dev-worker-group"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [module.dev-k8s-cluster.aws_security_group_1]
      asg_desired_capacity          = 1
    },
  ]
}