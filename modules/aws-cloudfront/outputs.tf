output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}

output "cloudfront_origin_iam_arn" {
  value = aws_cloudfront_origin_access_identity.cloudfront_origin.iam_arn
}
