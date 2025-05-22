terraform {
  backend "s3" {
    bucket = "bucket-for-3s3" # <— replace with YOUR bucket name
    key    = "tf-hw1/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}

locals {
  bucket_names = [
    "ben-tentech-bucket-one",
    "ben-tentech-bucket-two",
    "ben-tentech-bucket-three"
  ]
}


resource "aws_s3_bucket" "buckets" {
  for_each = toset(local.bucket_names)

  bucket = each.key
  tags = {
    Project = "tf-hw1"
  }
}

locals {
  vpc_cidrs = {
    vpc_a = "10.0.0.0/16"
    vpc_b = "10.1.0.0/16"
    vpc_c = "10.2.0.0/16"
  }
}

resource "aws_vpc" "vpcs" {
  for_each   = local.vpc_cidrs
  cidr_block = each.value

  tags = {
    Name    = "${each.key}"
    Project = "tf-hw1"
  }
}
