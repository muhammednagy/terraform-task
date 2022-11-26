resource "aws_s3_bucket" "content_bucket" {
  provider      = aws.s3
  bucket        = var.s3bucket
  force_destroy = true
  tags = {
    name = "Demo bucket"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  provider = aws.s3
  bucket   = var.s3bucket
  policy   = data.aws_iam_policy_document.s3_private_bucket.json
}

data "aws_iam_policy_document" "s3_private_bucket" {
  provider = aws.s3
  statement {
    sid = "1"

    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListBucket",
    ]

    effect = "Allow"

    resources = [
      aws_s3_bucket.content_bucket.arn,
      "${aws_s3_bucket.content_bucket.arn}/*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        aws_cloudfront_origin_access_identity.cloudfront_origin.iam_arn
      ]
    }
  }
}

resource "aws_s3_object" "file_upload" {
  provider = aws.s3
  bucket   = var.s3bucket
  key      = "index.html"
  source   = "${path.module}/index.html"
  etag     = filemd5("${path.module}/index.html")
}
