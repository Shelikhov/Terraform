#=============================================
#                K8s Project
#=============================================

provider "aws" {
  region = var.aws_region
}

locals {
  network = data.terraform_remote_state.network.outputs
}

# Loadbalancer for master nodes.
module "loadbalancer" {
  source           = "git@github.com:Shelikhov/Terraform.git//aws/modules/lb-module?ref=develop"
  project_name     = var.project_name
  sg_ingress_rules = var.elb_sg_ingress_rules
  lb_listeners     = var.lb_listeners
  lb_health_check  = var.lb_health_check
  subnets          = [local.network.custom_public_subnet_ids[0]]
  vpc_id           = local.network.vpc_id
}

# Autoscaling Group for Etcd nodes.
module "asg_etcd_nodes" {
  source                 = "git@github.com:Shelikhov/Terraform.git//aws/modules/asg-module?ref=develop"
  file_user_data         = var.etcd_node_file_user_data
  ec2_ssh_key_name       = var.etcd_ec2_ssh_key_name
  ec2_file_ssh_key_path  = var.etcd_ec2_ssh_key_path
  launch_template_name   = var.etcd_launch_template_name
  asg_name               = var.etcd_asg_name
  instance_type          = var.etcd_instance_type
  instance_image_id      = var.etcd_instance_image_id
  instance_min_count     = var.etcd_instance_min_count
  instance_max_count     = var.etcd_instance_max_count
  instance_desired_count = var.etcd_instance_desired_count
  termination_policies   = var.etcd_termination_policies
  sg_ingress_rules       = var.etcd_sg_ingress_rules
  vpc_id                 = local.network.vpc_id
  subnets                = [local.network.custom_private_subnet_ids[0]]
}

# Autoscaling Group for master nodes.
module "asg_master_nodes" {
  source                 = "git@github.com:Shelikhov/Terraform.git//aws/modules/asg-module?ref=develop"
  file_user_data         = var.master_node_file_user_data
  ec2_ssh_key_name       = var.master_ec2_ssh_key_name
  ec2_file_ssh_key_path  = var.master_ec2_ssh_key_path
  launch_template_name   = var.master_launch_template_name
  asg_name               = var.master_asg_name
  instance_type          = var.master_instance_type
  instance_image_id      = var.master_instance_image_id
  instance_min_count     = var.master_instance_min_count
  instance_max_count     = var.master_instance_max_count
  instance_desired_count = var.master_instance_desired_count
  termination_policies   = var.master_termination_policies
  sg_ingress_rules       = var.master_sg_ingress_rules
  vpc_id                 = local.network.vpc_id
  subnets                = [local.network.custom_private_subnet_ids[0]]
  loadbalancer_name      = var.project_name

  depends_on = [
    module.loadbalancer
  ]
}

# Autoscaling Group for worker nodes.
module "asg_worker_nodes" {
  source                 = "git@github.com:Shelikhov/Terraform.git//aws/modules/asg-module?ref=develop"
  file_user_data         = var.worker_node_file_user_data
  ec2_ssh_key_name       = var.worker_ec2_ssh_key_name
  ec2_file_ssh_key_path  = var.worker_ec2_ssh_key_path
  launch_template_name   = var.worker_launch_template_name
  asg_name               = var.worker_asg_name
  instance_type          = var.worker_instance_type
  instance_image_id      = var.worker_instance_image_id
  instance_min_count     = var.worker_instance_min_count
  instance_max_count     = var.worker_instance_max_count
  instance_desired_count = var.worker_instance_desired_count
  termination_policies   = var.worker_termination_policies
  sg_ingress_rules       = var.worker_sg_ingress_rules
  vpc_id                 = local.network.vpc_id
  subnets                = [local.network.custom_private_subnet_ids[1]]

  depends_on = [
    module.asg_master_nodes
  ]
}

module "bastion_host" {
  source                = "git@github.com:Shelikhov/Terraform.git//aws/modules/ec2-module?ref=develop"
  file_user_data        = var.bastion_file_user_data
  ec2_ssh_key_name      = var.bastion_ec2_ssh_key_name
  ec2_file_ssh_key_path = var.bastion_ec2_ssh_key_path
  instance_type         = var.bastion_instance_type
  ami                   = var.bastion_ami
  sg_ingress_rules      = var.bastion_sg_ingress_rules
  sg_egress_rules       = var.bastion_sg_egress_rules
  vpc_id                = local.network.vpc_id
  subnet_id             = local.network.custom_public_subnet_ids[0]
}
