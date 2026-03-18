module "backend" {
  source = "../../modules/backend"

  bucket_name         = "karim-eks-terraform-state-prod"
  dynamodb_table_name = "terraform-state-lock-prod"
  environment         = "prod"
}

