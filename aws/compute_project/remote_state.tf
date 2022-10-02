terraform {
  backend "s3" {
    bucket = "web-server-linux-prefix"
    key = "terraform/dev/compute"
    region = "us-east-2"
  }
}
