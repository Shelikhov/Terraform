#=============================================
#               VARIABLES
#=============================================

### Common ###

variable "project_name" {
  default = "custom_name"
}

variable "tags" {
  type = map(any)
  default = {
    custom_name = "custom_name"
    environment = "dev"
  }
}



### Security Group ###

variable "sg_ingress_rules" {
  default = [
    {
      port        = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "sg_egress_rules" {
  default = [
    {
      port        = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "sg_name_prefix_length" {
  default = 5
}



### EC2 Instance ###

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

variable "subnet_id" {
  default = ""
}

variable "ec2_ssh_key_name" {
  default = ""
}

variable "ec2_file_ssh_key_path" {
  default = ""
}

variable "file_user_data" {
  default = ""
}

variable "vpc_id" {
  default = ""
}
