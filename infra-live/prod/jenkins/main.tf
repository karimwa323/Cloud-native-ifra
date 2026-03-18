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

# module "jenkins" {
#   source = "../../modules/jenkins"

#   project_name = "cloud-native-end-to-end"
#   vpc_id           = data.terraform_remote_state.network.outputs.vpc_id
#   subnet_id = data.terraform_remote_state.network.outputs.public_subnets[0]
#   iam_instance_profile = data.terraform_remote_state.iam.outputs.jenkins_profile_name
#   instance_type = "m7i-flex.large"
#   key_name = "frankfurt_key_pair"
# }

# resource "aws_eip" "jenkins_eip" {
#   instance = module.jenkins.instance_id
#   domain   = "vpc" 

#   tags = {
#     Name = "jenkins-static-ip"
#   }
# }

# output "jenkins_static_public_ip" {
#   value = aws_eip.jenkins_eip.public_ip
# }