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