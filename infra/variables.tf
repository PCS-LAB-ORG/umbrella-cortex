variable "owner" {
  description = "Owner of the resources"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
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