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
  description = "Please enter alternate domain to be used to serve from"
  type        = string
  validation {
    condition = var.alternate_domain != ""
    error_message = "alternate_domain cannot be empty"
  }
}

variable "subdomain_for_alternate_domain" {
  description = "Please enter subdomain to be used with provided alternate domain (leave empty if you don't want to use subdomains)"
  type        = string
  default = ""
}