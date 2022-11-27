#=============================================
#               VARIABLES
#=============================================

### Common vars ###

variable "project_name" {
  default = "web_server"
}

variable "tags" {
  type = map(any)
  default = {
    project_name = "web_server"
    environment  = "dev"
  }
}


### VPC ###

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}


### Subnets ###

variable "public_subnets" {
  default = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_subnets" {
  default = ["10.0.32.0/20", "10.0.48.0/20"]
}


### Route Tables ###

variable "vpc_routes" {
  type = map(any)
  default = {
    destination = "0.0.0.0/0"
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
