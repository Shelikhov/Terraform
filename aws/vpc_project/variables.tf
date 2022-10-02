variable "region" {
  default = "us-east-2"
}

variable "project_name" {
  default = "web_server_linux"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_subnets" {
  default = ["10.0.32.0/20", "10.0.48.0/20"]
}

variable "vpc_routes" {
  type = map
  default = {
    destination = "0.0.0.0/0"
  }
}

variable "tags" {
  type = map
  default = {
    project_name = "web_server_linux"
    environment = "dev"
  }
}
