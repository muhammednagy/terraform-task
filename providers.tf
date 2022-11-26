terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40.0"
    }
  }
}

provider "aws" {
  alias   = "cloudfront"
  profile = "cloudfront"
  region  = var.region
}

provider "aws" {
  alias   = "s3"
  profile = "s3"
  region  = var.region
}

data "aws_caller_identity" "cloudfront" {
  provider = aws.cloudfront
}