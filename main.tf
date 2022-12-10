data "aws_route53_zone" "domain_zone" {
  provider = aws.cloudfront
  name     = var.alternate_domain
}

locals {
  domain_name = var.subdomain_for_alternate_domain != "" && var.alternate_domain != "" ? "${var.subdomain_for_alternate_domain}.${var.alternate_domain}" : var.alternate_domain
}

module "certificate" {
  source = "./modules/aws-acm"
  providers = {
    aws : aws.cloudfront
  }
  domain = local.domain_name
}

module "certificate_verification" {
  source = "./modules/aws-r53-record"
  providers = {
    aws : aws.cloudfront
  }

  for_each = {
    for dvo in module.certificate.acm_certificate_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  route53_zone_id = data.aws_route53_zone.domain_zone.id
  target          = each.value.record
  type            = each.value.type
  name            = each.value.name
}

module "cloudfront" {
  source = "./modules/aws-cloudfront"
  providers = {
    aws : aws.cloudfront
  }

  comment             = "Nagy's Awesome cloudfront distribution"
  acm_certificate_arn = module.certificate.acm_certificate_arn
  alias               = local.domain_name
  bucket_name         = var.s3bucket
}

module "cdn_dns_record" {
  source = "./modules/aws-r53-record"
  providers = {
    aws : aws.cloudfront
  }

  route53_zone_id = data.aws_route53_zone.domain_zone.id
  target          = module.cloudfront.cloudfront_distribution_domain_name
  type            = "CNAME"
  name            = var.subdomain_for_alternate_domain
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
  create_bucket             = var.create_bucket
}