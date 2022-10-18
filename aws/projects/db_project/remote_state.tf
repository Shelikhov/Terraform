terraform {
  backend "s3" {
    bucket = "" # The field for bucket name
    key    = "terraform/projects/db_project"
    region = "us-east-2"
  }
}
