variable "region" {
  default     = "eu-central-1"
  description = "AWS region"
}

variable "environment" {
  default = "dev"
  type    = string
}

variable "worker_groups" {
  default = []
  type = any
}