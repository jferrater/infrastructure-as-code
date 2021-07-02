variable "ip_whitelist" {
  type = list(string)
}

variable "instance_image_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "scaling_desired_capacity" {
  type = number
}
variable "scaling_max_size" {
  type = number
}
variable "scaling_min_size" {
  type = number
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_s3_bucket" "dev_s3_bucket" {
  bucket = "dev-s3-bucket-20210701"
  acl    = "private"

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_default_vpc" "default" {}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "eu-central-1a"

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "eu-central-1b"

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_security_group" "dev_web" {
  name        = "dev_web"
  description = "Allow standard http and https ports inbound and everything outbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # TO DO: replace with my host ip
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # TO DO: replace with my host ip
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #allow all protocols
    cidr_blocks = var.ip_whitelist
  }

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_elb" "dev_web" {
  name      = "dev-web"
  subnets = [
    aws_default_subnet.default_az1.id,
    aws_default_subnet.default_az2.id
  ]
  security_groups = [
    aws_security_group.dev_web.id
  ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_launch_template" "dev_web" {
  name_prefix   = "dev-web"
  image_id      =  var.instance_image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.dev_web.id ]
}

resource "aws_autoscaling_group" "dev_web" {
  desired_capacity    = var.scaling_desired_capacity
  max_size            = var.scaling_max_size
  min_size            = var.scaling_min_size

  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]

  launch_template {
    id      = aws_launch_template.dev_web.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "dev_web" {
  autoscaling_group_name = aws_autoscaling_group.dev_web.id
  elb                    = aws_elb.dev_web.id
}

output "website" {
  value = aws_elb.dev_web.dns_name
  description = "The domain name of the load balancer, the gateway to access the Bitnami website"
}