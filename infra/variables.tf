variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Tag owner for all resources"
  type        = string
  default     = "mdalbes"
}