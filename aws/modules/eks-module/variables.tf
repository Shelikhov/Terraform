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
  default = "ami-0f924dc71d44d23e2"
}

variable "instance_types" {
  default = ["t2.micro"]
}

variable "scaling_config" {
  default = {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }
}

variable "ec2_file_ssh_id_rsa_path" {
  default = ""
}
