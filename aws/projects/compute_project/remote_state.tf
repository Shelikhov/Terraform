terraform {
  backend "s3" {
    bucket = "bucket_name"
    key = "terraform/projects/compute_project"
    region = "us-east-2"
  }
}
