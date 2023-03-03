#=============================================
#               VARIABLES
#=============================================

### Common vars ###

variable "project_name" {
  default = "project_name"
}

variable "tags" {
  type = map(any)
  default = {
    project_name = "project_name"
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
