#=============================================
#               VARIABLES
#=============================================

variable "aws_region" {
  default = "us-east-2"
}

#Only alphanumeric value for ELB
variable "project_name" {
  default = "custom"
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

#6443: kubernetes api server
variable "sg_ingress_rules" {
  default = [
    {
      port        = 6443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

### ELB ###

variable "lb_listeners" {
  default = [
    {
      lb_port           = "6443"
      lb_protocol       = "TCP"
      instance_port     = "6443"
      instance_protocol = "TCP"
    }
  ]
}

variable "lb_health_check" {
  default = [
    {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
      target              = "SSL:6443"
      interval            = 20
    }
  ]
}
