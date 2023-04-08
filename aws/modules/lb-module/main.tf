#=============================================
#           LOADBALANCER'S RESOURCES
#=============================================



################# RESOURCES ###################

### Security Group ###

resource "aws_security_group" "elb_security_group" {
  name   = "elb-${var.project_name}-${random_string.sg_name_prefix.result}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_egress_rules
    content {
      from_port   = egress.value["port"]
      to_port     = egress.value["port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
  tags = var.tags
}

resource "random_string" "sg_name_prefix" {
  length  = var.sg_name_prefix_length
  special = false
  lower   = true
  upper   = false
}


### Elastic Load Balancer ###

resource "aws_elb" "loadbalancer" {
  name            = var.project_name
  subnets         = var.subnets
  security_groups = [aws_security_group.elb_security_group.id]
  dynamic "listener" {
    for_each = var.lb_listeners
    content {
      lb_port           = listener.value["lb_port"]
      lb_protocol       = listener.value["lb_protocol"]
      instance_port     = listener.value["instance_port"]
      instance_protocol = listener.value["instance_protocol"]
    }
  }
  dynamic "health_check" {
    for_each = var.lb_health_check
    content {
      healthy_threshold   = health_check.value["healthy_threshold"]
      unhealthy_threshold = health_check.value["unhealthy_threshold"]
      timeout             = health_check.value["timeout"]
      target              = health_check.value["target"]
      interval            = health_check.value["interval"]
    }
  }
  tags = var.tags
}
