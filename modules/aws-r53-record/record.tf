resource "aws_route53_record" "r53-cname" {
  zone_id         = var.route53_zone_id
  name            = var.name
  type            = var.type
  allow_overwrite = true
  ttl             = "300"
  records         = [var.target]
}