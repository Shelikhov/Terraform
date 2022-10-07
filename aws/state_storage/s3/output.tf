output "region" {
  value = var.region
}

output "s3_bucket_name" {
  value = "${var.project_name}-${random_string.bucket_prefix.result}"
}
