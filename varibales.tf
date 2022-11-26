variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "s3bucket" {
  description = "Please enter s3 bucket name"
  default     = "nagy-content-bucket"
  type        = string
}
