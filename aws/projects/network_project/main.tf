provider "aws" {
  region = var.aws_region
}

module "network_project" {
  source = "git@github.com:Shelikhov/Terraform.git//aws/modules/network-module?ref=develop"
}
