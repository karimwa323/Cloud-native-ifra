data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "karim-eks-terraform-state-prod"
    key    = "prod/network/terraform.tfstate" 
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket = "karim-eks-terraform-state-prod"
    key    = "prod/IAM/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "jenkins" {
  backend = "s3"
  config = {
    bucket = "karim-eks-terraform-state-prod"
    key    = "prod/jenkins/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket = "karim-eks-terraform-state-prod"
    key    = "prod/ECR/terraform.tfstate"
    region = "eu-central-1"
  }
}


module "eks" {
  source           = "../../modules/EKS"
  cluster_name     = "cloud-native-eks-prod"
  environment      = "prod"
  cluster_role_arn = data.terraform_remote_state.iam.outputs.cluster_role_arn
  node_role_arn    = data.terraform_remote_state.iam.outputs.node_role_arn
  subnet_ids       = data.terraform_remote_state.network.outputs.private_subnets 
}