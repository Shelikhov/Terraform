variable "aws_region" {
  default = "us-east-2"
}

variable "web_server_script_file_path" {
  default = ""
}

variable "ec2_file_ssh_id_rsa_path" {
  default = ""
}

variable "state_storage_type" {
  default = "s3"
}

variable "s3_bucket_name" {
  default = ""
}

variable "s3_key_path" {
  default = "terraform/projects/network_project"
}
