#=============================================
#         Terraform State file location
#=============================================

terraform {
  backend "s3" {
    bucket = ""
    key    = "terraform/projects/k8s_project"
    region = "us-east-2"
  }
}
