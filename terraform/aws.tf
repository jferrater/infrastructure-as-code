provider "aws" {
  profile = "default"
  region = "eu-central-1"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my_s3_bucket_20210701"
}