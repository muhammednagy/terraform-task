resource "aws_s3_bucket" "content_bucket" {
  count         = var.create_bucket ? 1 : 0
  bucket        = var.s3bucket
  force_destroy = true
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  depends_on = [aws_s3_bucket.content_bucket]
  bucket     = var.s3bucket
  policy     = data.aws_iam_policy_document.s3_private_bucket.json
}

data "aws_iam_policy_document" "s3_private_bucket" {
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
      data.aws_s3_bucket.content_bucket.arn,
      "${data.aws_s3_bucket.content_bucket.arn}/*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        var.cloudfront_origin_iam_arn
      ]
    }
  }
}

resource "aws_s3_object" "file_upload" {
  depends_on = [
    aws_s3_bucket.content_bucket
  ]

  bucket       = var.s3bucket
  key          = "index.html"
  content_type = "text/html"
  source       = var.index_file_path
  etag         = filemd5(var.index_file_path)
}
