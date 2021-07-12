module "staging-k8s-cluster" {
  source = "../../aws-eks"

  environment = "staging"

    worker_groups = [
    {
      name                          = "staging-worker-group"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [module.staging-k8s-cluster.aws_security_group_1]
    },
    {
      name                          = "staging-worker-group"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [module.staging-k8s-cluster.aws_security_group_1]
      asg_desired_capacity          = 1
    },
  ]
}