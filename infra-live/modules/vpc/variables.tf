variable "project_name" {
  description = "Project name for tagging resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of CIDRs for Public Subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDRs for Private Subnets"
  type        = list(string)
}