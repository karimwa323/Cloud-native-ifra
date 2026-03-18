terraform {
  backend "s3" {
    bucket         = "karim-eks-terraform-state-prod" 
    key            = "prod/ECR/terraform.tfstate"  
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock-prod"
    encrypt        = true
  }
}