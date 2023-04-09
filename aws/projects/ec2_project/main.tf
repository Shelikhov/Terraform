#=============================================
#           AutoScaling Group Project
#=============================================

provider "aws" {
  region = var.aws_region
}

locals {
  network = data.terraform_remote_state.network.outputs
}

module "ec2_project" {
  source                = "git@github.com:Shelikhov/Terraform.git//aws/modules/ec2-module?ref=develop"
  file_user_data        = var.file_user_data
  ec2_file_ssh_key_path = var.ec2_file_ssh_key_path
  instance_type         = var.instance_type
  ami                   = var.ami
  sg_ingress_rules      = var.sg_ingress_rules
  vpc_id                = local.network.vpc_id
  subnet_id             = local.network.custom_public_subnet_ids[0]
}
