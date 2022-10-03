provider "aws" {
  region = var.aws_region
}

module "compute_project" {
  source = "git@github.com:Shelikhov/Terraform.git//aws/modules/compute-module?ref=develop"
  file_user_data = var.web_server_script_file_path
  ec2_file_ssh_id_rsa_path = var.ec2_file_ssh_id_rsa_path
  state_storage_type = var.state_storage_type
  s3_bucket_name = var.s3_bucket_name
  s3_key_path = var.s3_key_path
  aws_region = var.aws_region
}
