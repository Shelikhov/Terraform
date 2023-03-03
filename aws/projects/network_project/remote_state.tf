#===============================================================
#                  Terraform state storage
#===============================================================

terraform {
  backend "s3" {
    bucket = ""
    key    = "terraform/projects/network_project"
    region = "us-east-2"
  }
}
