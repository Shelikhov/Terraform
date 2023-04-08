#===========================================================
#                  NETWORK PROJECT
#===========================================================

provider "aws" {
  region = var.aws_region
}

module "network_project" {
  source          = "git@github.com:Shelikhov/Terraform.git//aws/modules/network-module?ref=develop"
  project_name    = var.project_name
  tags            = merge(var.tags, { "kubernetes.io/cluster/${var.project_name}" = "1" })
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
