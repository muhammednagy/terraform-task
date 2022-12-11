variable "name" {
  type    = string
  default = ""
}

variable "target" {
  type = string
  validation {
    condition     = var.target != ""
    error_message = "target can't be empty"
  }
}

variable "type" {
  type = string
  validation {
    condition     = var.type != ""
    error_message = "Type can't be empty"
  }
}

variable "route53_zone_id" {
  type = string
}