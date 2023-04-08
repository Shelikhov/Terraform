#=============================================
#           AutoScaling Group Project
#=============================================

provider "aws" {
  region = var.aws_region
}

locals {
  network = data.terraform_remote_state.network.outputs
}

module "asg_project" {
  source                   = "git@github.com:Shelikhov/Terraform.git//aws/modules/asg-module?ref=develop"
  file_user_data           = var.file_user_data
  ec2_file_ssh_id_rsa_path = var.ec2_file_ssh_id_rsa_path
  instance_type            = var.instance_type
  instance_image_id        = var.instance_image_id
  sg_ingress_rules         = var.sg_ingress_rules
  instance_desired_count   = var.instance_desired_count
  termination_policies     = var.termination_policies
  vpc_id                   = local.network.vpc_id
  subnets                  = [local.network.custom_public_subnet_ids[0]]
}
