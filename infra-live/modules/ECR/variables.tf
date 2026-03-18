variable "repo_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, dev)"
  type        = string
}

variable "image_tag_mutability" {
  description = " Mutability"
  type        = string
  default     = "IMMUTABLE" 
}

variable "scan_on_push" {
  description = " Scan on push "
  type        = bool
  default     = true
}