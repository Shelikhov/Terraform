variable "aws_region" {
  default = "us-east-2"
}

variable "state_storage_type" {
  default = "s3"
}

variable "s3_bucket_name" {
  default = "" # Bucket name for the network module
}

variable "s3_key_path" {
  default = "terraform/projects/network_project"
}

variable "rds_db_name" {
  default = "web_server"
}

variable "rds_db_username" {
  default = "username"
}
