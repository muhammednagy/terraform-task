variable "s3bucket" {
  description = "Please enter s3 bucket name"
  type        = string
}

variable "create_bucket" {
  description = "Do you want to create an s3 bucket?"
  type        = bool
  default     = true
}

variable "cloudfront_origin_iam_arn" {
  description = "IAM role for cloudfront origin"
  type        = string
}

variable "index_file_path" {
  description = "path for index file for bucket"
  type        = string
}