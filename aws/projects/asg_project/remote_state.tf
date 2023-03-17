#=============================================
#         Terraform State file location
#=============================================

terraform {
  backend "s3" {
    bucket = "web-server-linux-..."
    key    = "terraform/projects/asg_project"
    region = "us-east-2"
  }
}
