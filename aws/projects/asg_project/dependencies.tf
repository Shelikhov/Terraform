#=============================================
#               DEPENDENCIES
#=============================================

data "terraform_remote_state" "network" {
  backend = var.state_storage_type
  config = {
    bucket = var.s3_bucket_name
    key    = var.s3_key_path
    region = var.aws_region
  }
}
