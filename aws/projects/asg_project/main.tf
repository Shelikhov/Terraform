#=============================================
#           AutoScaling Group Project
#=============================================

provider "aws" {
  region = var.aws_region
}

module "asg_project" {
  source                   = "git@github.com:Shelikhov/Terraform.git//aws/modules/asg-module?ref=develop"
  file_user_data           = var.file_user_data
  ec2_file_ssh_id_rsa_path = var.ec2_file_ssh_id_rsa_path
  state_storage_type       = var.state_storage_type
  s3_bucket_name           = var.s3_bucket_name
  s3_key_path              = var.s3_key_path
  aws_region               = var.aws_region
}
