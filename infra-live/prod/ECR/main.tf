data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "karim-eks-terraform-state-prod"
    key    = "prod/network/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "ecr" {
  source      = "../../modules/ECR"
  repo_name   = "cloud-native-app"
  environment = "prod"
}


module "ecr-2" {
  source      = "../../modules/ECR"
  repo_name   = "cloud-native-backend"
  environment = "prod"
}