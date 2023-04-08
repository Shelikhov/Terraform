#=====================================
#           VARIABLES
#=====================================

variable "aws_region" {
  default = "us-east-2"
}

variable "project_name" {
  default = "k8s"
}

variable "tags" {
  type = map(any)
  default = {
    project_name = "k8s"
    environment  = "dev"
  }
}

variable "public_subnets" {
  default = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_subnets" {
  default = ["10.0.32.0/20", "10.0.48.0/20"]
}
