variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN to be used with alias"
  default     = null
}

variable "bucket_name" {
  type    = string
  default = null
}

variable "comment" {
  type = string
}

variable "alias" {
  type    = string
  default = ""
}
