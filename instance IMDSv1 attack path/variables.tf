variable "region" {
  type        = string
  description = "AWS region"
}

variable "owner" {
  type        = string
  description = "Owner tag for resources"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key"
  type        = string
  sensitive   = true
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS  access key ID"
  type        = string
  sensitive   = true
}