provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_s3_bucket" "dev_s3_bucket" {
  bucket = "dev-s3-bucket-20210701"
  acl    = "private"
}

resource "aws_default_vpc" "default" {
  
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_instance" "dev_web" {
  ami           = "ami-01b4c2304da3f0c4f"
  instance_type = "t2.nano"

  vpc_security_group_ids = [ 
    aws_security_group.dev_web.id 
  ]

  tags = {
    "Terraform" : "true"
  }
}