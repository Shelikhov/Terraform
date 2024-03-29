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

variable "ssh_key_name_prefix_length" {
  default = 5
}

variable "launch_template_name" {
  default = "custom"
}

variable "asg_name" {
  default = "custom"
}

variable "instance_image_id" {
  default = "ami-0f924dc71d44d23e2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_max_count" {
  default = 3
}

variable "instance_min_count" {
  default = 1
}

variable "instance_desired_count" {
  default = 1
}

variable "termination_policies" {
  default = ["Default"]
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

variable "subnets" {
  default = []
}

variable "vpc_id" {
  default = ""
}

variable "loadbalancer_name" {
  default = ""
}
