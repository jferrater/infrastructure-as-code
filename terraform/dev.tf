provider "aws" {
  profile = "default"
  region = "eu-central-1"
}

resource "aws_s3_bucket" "dev_s3_bucket" {
  bucket = "dev_s3_bucket_20210701"
  acl = "private"
}