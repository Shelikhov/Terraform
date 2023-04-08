#=============================================
#               VARIABLES
#=============================================

### Common ###

#Only alphanumeric value for ELB name
variable "project_name" {
  default = "custom"
}

variable "tags" {
  type = map(any)
  default = {
    project_name = "custom"
    environment = "dev"
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



### ELB ###

variable "lb_listeners" {
  default = [
    {
      lb_port           = "80"
      lb_protocol       = "http"
      instance_port     = "80"
      instance_protocol = "http"
    }
  ]
}

variable "lb_health_check" {
  default = [
    {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
      target              = "HTTP:80/"
      interval            = 10
    }
  ]
}

variable "subnets" {
  default = []
}

variable "vpc_id" {
  default = ""
}
