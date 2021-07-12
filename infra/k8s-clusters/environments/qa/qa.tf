module "qa-k8s-cluster" {
  source = "../../aws-eks"

  environment = "qa"

  worker_groups = [
    {
      name                          = "qa-worker-group"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [module.qa-k8s-cluster.aws_security_group_1]
    },
    {
      name                          = "qa-worker-group"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [module.qa-k8s-cluster.aws_security_group_1]
      asg_desired_capacity          = 1
    },
  ]
}