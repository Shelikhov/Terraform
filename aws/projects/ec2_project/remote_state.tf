#=============================================
#         Terraform State file location
#=============================================

terraform {
  backend "s3" {
    bucket = ""
    key    = "terraform/projects/ec2_project"
    region = "us-east-2"
  }
}
