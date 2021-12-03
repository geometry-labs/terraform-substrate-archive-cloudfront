variable "aws_region" {
  default = "us-east-2"
}

provider "aws" {
  region = var.aws_region
}

resource "random_pet" "this" {
  length = 2
}

resource "aws_s3_bucket" "this" {
  bucket = random_pet.this.id
}

module "default" {
  source           = "../.."
  s3_bucket_name   = aws_s3_bucket.this.bucket
  root_domain_name = ""
}
