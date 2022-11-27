data "aws_s3_bucket" "content_bucket" {
  depends_on = [
    aws_s3_bucket.content_bucket
  ]
  bucket = var.s3bucket
}