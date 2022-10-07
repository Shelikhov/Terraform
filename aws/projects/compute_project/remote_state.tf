terraform {
  backend "s3" {
    bucket = "web-server-linux-vl3p2"
    key    = "terraform/projects/compute_project"
    region = "us-east-2"
  }
}
