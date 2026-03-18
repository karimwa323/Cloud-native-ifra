data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "karim-eks-terraform-state-prod"
    key    = "prod/network/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "iam" {
  source      = "../../modules/IAM"
  environment = "prod"
}

output "cluster_role_arn" {
  value = module.iam.cluster_role_arn
}

output "node_role_arn" {
  value = module.iam.node_role_arn
}

# output "jenkins_profile_name" {
#   value = module.iam.jenkins_profile_name
# }

# output "jenkins_role_arn" {
#   value = module.iam.jenkins_role_arn
# }