provider "aws" {
  region = var.aws_region
}

locals {
  network = data.terraform_remote_state.network.outputs
}

module "lb_project" {
  source           = "git@github.com:Shelikhov/Terraform.git//aws/modules/lb-module?ref=develop"
  project_name     = var.project_name
  sg_ingress_rules = var.sg_ingress_rules
  lb_listeners     = var.lb_listeners
  lb_health_check  = var.lb_health_check
  subnets          = [local.network.custom_public_subnet_ids[0]]
  vpc_id           = local.network.vpc_id
}
