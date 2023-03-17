#=============================================
#               VARIABLES
#=============================================

variable "aws_region" {
  default = "us-east-2"
}

variable "file_user_data" {
  default = "" # Script for ec2 initializing
}

variable "ec2_file_ssh_id_rsa_path" {
  default = "" # SSH key location to get access to ec2 instances
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
