variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "web-server-linux"
}

variable "instance_image_id" {
  default = "ami-05fa00d4c63e32376"
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
  default = 3
}

variable "instance_ingress_ports" {
  type = list
  default = ["0"]
}

variable "instance_ingress_protocol" {
  default = -1
}

variable "instance_ingress_cidr" {
  type = list
  default = ["0.0.0.0/0"]
}
variable "instance_egress_cidr" {
  type = list
  default = ["0.0.0.0/0"]
}

variable "instance_egress_ports" {
  type = list
  default = ["0"]
}

variable "instance_egress_protocol" {
  default = -1
}

variable "tags" {
  type = map
  default = {
    project_name = "web_server_linux"
    environment = "dev"
  }
}


variable "lb_ports" {
  type = list
  default = ["80"]
}

variable "file_ssh_id_rsa" {
  default = "/root/terraform/id_rsa.pub"
}

variable "file_uaer_data" {
  default = "/root/terraform/webserver-script.sh.tpl"
}

variable "public_subnets" {
  default = ["172.31.96.0/20", "172.31.112.0/20"]
}

variable "private_subnets" {
  default = ["172.31.128.0/20", "172.31.144.0/20"]
}
