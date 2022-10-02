#To change s3 bucket name

terraform {
  backend "s3" {
    bucket = "web-server-linux-prifix"
    key = "terraform/dev/network"
    region = "us-east-2"
  }
}
