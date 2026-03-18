resource "aws_ecr_repository" "app_repo" {
  name                 = var.repo_name 
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = var.repo_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
