locals {
  use_alternate_domain = var.alternate_domain != "" && var.certificate_arn != "" ? true : false
}

module "cloudfront" {
  source = "./modules/aws-cloudfront"
  providers = {
    aws : aws.cloudfront
  }

  comment             = "Nagy's Awesome cloudfront distribution"
  acm_certificate_arn = local.use_alternate_domain ? var.certificate_arn : null
  alias               = var.alternate_domain
  bucket_name         = var.s3bucket
}

module "s3" {
  source = "./modules/aws-s3"
  depends_on = [
    module.cloudfront
  ]
  providers = {
    aws : aws.s3
  }

  cloudfront_origin_iam_arn = module.cloudfront.cloudfront_origin_iam_arn
  s3bucket                  = var.s3bucket
  index_file_path           = "${path.root}/include/index.html"
}