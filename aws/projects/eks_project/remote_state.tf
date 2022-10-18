terraform {
  backend "s3" {
    bucket = "" # Bucket name
    key    = "terraform/projects/eks_project"
    region = "us-east-2"
  }
}
