#=============================================
#               DEPENDENCIES
#=============================================

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "bucket_name"
    key = "state_path"
    region = "region"
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}
