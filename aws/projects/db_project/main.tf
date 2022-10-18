provider "aws" {
  region = var.aws_region
}

module "db_project" {
  source                   = "git@github.com:Shelikhov/Terraform.git//aws/modules/db-module?ref=develop"
  rds_db_name              = var.rds_db_name
  rds_db_username          = var.rds_db_username
  state_storage_type       = var.state_storage_type
  s3_bucket_name           = var.s3_bucket_name
  s3_key_path              = var.s3_key_path
  aws_region               = var.aws_region
}
