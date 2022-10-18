### Common ###

variable "tags" {
  type = map(any)
  default = {
    project_name = "web_server_linux"
    environment  = "dev"
  }
}



### Network Dependencies ###

variable "state_storage_type" {
  default = "s3"
}

variable "s3_bucket_name" {
  default = ""
}

variable "s3_key_path" {
  default = ""
}

variable "aws_region" {
  default = "us-east-2"
}


### EKS Node Group ###

variable "instance_image_id" {
  default = "AL2_x86_64"
}

variable "instance_types" {
  default = ["t2.micro"]
}

variable "scaling_config_min" {
  default = 1
}

variable "scaling_config_max" {
  default = 2
}

variable "scaling_config_desired" {
  default = 2
}

variable "ec2_file_ssh_id_rsa_path" {
  default = ""
}
