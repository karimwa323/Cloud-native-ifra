module "vpc" {
  source       = "../../modules/vpc"
  project_name = "cloud-native-end-to-end"
  vpc_cidr     = "10.0.0.0/16"
  azs          = ["eu-central-1a", "eu-central-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
}