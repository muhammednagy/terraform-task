output "bucket_name" {
  value = aws_s3_bucket.content_bucket.bucket
}

output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}

locals {
  use_alternate_domain = var.alternate_domain != "" && var.certificate_arn != "" ? true : false
}