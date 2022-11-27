variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "s3bucket" {
  description = "Please enter s3 bucket name"
  default     = "nagy-content-bucket"
  type        = string
}

variable "create_bucket" {
  description = "Do you want to create an s3 bucket?"
  default     = true
  type        = bool
}

variable "alternate_domain" {
  description = "Please enter alternate domain to be used to serve from (must provide certificate ARN as well, leave empty in case not needed)"
  type        = string
}

variable "certificate_arn" {
  description = "Please enter  certificate ARN to be used with alternate domain (leave empty in case not needed)"
  type        = string
}
