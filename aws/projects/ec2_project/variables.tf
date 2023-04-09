#=============================================
#               VARIABLES
#=============================================

variable "project_name" {
  default = "ec2-instance"
}

variable "aws_region" {
  default = "us-east-2"
}

variable "file_user_data" {
  default = "" # Script for ec2 initializing
}

variable "ec2_file_ssh_key_path" {
  default = ""
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

#ami-0103f211a154d64a6: Amazon Linux 2023
#ami-00eeedc4036573771: Ubuntu-22.04
#ami-0568936c8d2b91c4e: Ubuntu-20.04
#ami-02238ac43d6385ab3: Amazon linux
#ami-067a8829f9ae24c1c: RHEL 9
variable "ami" {
  default = "ami-0103f211a154d64a6"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "sg_ingress_rules" {
  default = [
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "sg_egress_rules" {
  default = [
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
