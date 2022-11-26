variable "s3bucket" {
  description = "Please enter s3 bucket name"
  type        = string
}

variable "cloudfront_origin_iam_arn" {
  description = "IAM role for cloudfront origin"
  type        = string
}

variable "index_file_path" {
  description = "path for index file for bucket"
  type = string
}