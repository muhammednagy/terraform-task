resource "aws_cloudfront_origin_access_identity" "cloudfront_origin" {
  provider = aws.cloudfront
  comment  = "cloudfront_origin"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  provider            = aws.cloudfront
  comment             = "Nagy's Awesome cloudfront distribution"
  enabled             = true
  http_version        = "http2"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"
  aliases             = local.use_alternate_domain ? [var.alternate_domain] : null

  origin {
    domain_name = aws_s3_bucket.content_bucket.bucket_regional_domain_name
    origin_id   = "cloudfront_origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_origin.cloudfront_access_identity_path
    }

  }

  default_cache_behavior {
    target_origin_id       = "cloudfront_origin"
    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 5400
    min_ttl     = 3600
    max_ttl     = 7200

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    forwarded_values {

      query_string            = false
      query_string_cache_keys = []
      headers                 = []

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn            = local.use_alternate_domain ? var.certificate_arn : null
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1"
  }

  custom_error_response {

    error_code         = 403
    response_code      = 404
    response_page_path = "/404.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
