terraform {
  backend "s3" {
    bucket = "bucket_name"
    key = "terraform/projects/network_project"
    region = "us-east-2"
  }
}
