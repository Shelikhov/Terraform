provider "aws"{
  region = var.region
}

resource "random_string" "bucket_prefix" {
  length = var.bucket_prefix_length
  special = false
  lower = true
  upper = false
}

resource "aws_s3_bucket" "web_server" {
  bucket = "${var.project_name}-${random_string.bucket_prefix.result}"
  versioning {
    enabled = true
  }
  force_destroy = true
  tags = var.tags
}
