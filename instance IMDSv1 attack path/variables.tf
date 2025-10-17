variable "region" {
  type        = string
  description = "AWS region"
}

variable "owner" {
  type        = string
  description = "Owner tag for resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where subnet is located"
}

variable "subnet_name" {
  type        = string
  description = "Name tag of the subnet public-a"
  default     = "public-a-${var.owner}"
}

variable "vpc_name" {
  type        = string
  description = "Name tag of the vpc umbrella_vpc"
  default     = "umbrella_vpc-${var.owner}"
}