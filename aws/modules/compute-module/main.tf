#=============================================
#           COMPUTE RESOURCES
#=============================================

locals {
  azs     = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1]]
  network = data.terraform_remote_state.network.outputs
}



################# RESOURCES ###################

### Security Group

resource "aws_security_group" "my_security_group" {
  name   = "${var.project_name}-${random_string.sg_name_prefix.result}"
  vpc_id = local.network.vpc_id

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




################### EC2 resources #########################

### Key Pair

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.project_name
  public_key = file("${var.ec2_file_ssh_id_rsa_path}")
  tags       = var.tags
}

### Launch Template

resource "aws_launch_template" "ec2_linux_template" {
  name          = var.project_name
  image_id      = var.instance_image_id
  instance_type = var.instance_type
  #  security_group_names = [aws_security_group.my_security_group.name] #Only one security_group_names or vpc_security_group_ids we can specify
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name               = aws_key_pair.ec2_key_pair.key_name
  user_data              = filebase64("${var.file_user_data}")
  tags                   = var.tags
  #  depends_on             = [aws_db_instance.postgresql]
}

### Auto Scaling Group

resource "aws_autoscaling_group" "ec2_ASG" {
  max_size         = var.instance_max_count
  min_size         = var.instance_min_count
  desired_capacity = var.instance_desired_count
  launch_template {
    id = aws_launch_template.ec2_linux_template.id
  }
  #  availability_zones = local.azs #Conflicts with vpc_zone_identifier
  vpc_zone_identifier = local.network.custom_public_subnet_ids
  load_balancers      = [aws_elb.web_server_loadbalancer.name]
}

################### ELB resources #########################

### Elastic Load Balancer

resource "aws_elb" "web_server_loadbalancer" {
  name = var.project_name
  #  availability_zones = local.azs[*] #Conflicts with subnets
  subnets         = local.network.custom_public_subnet_ids
  security_groups = [aws_security_group.my_security_group.id]
  dynamic "listener" {
    for_each = var.lb_listeners
    content {
      lb_port           = listener.value["lb_port"]
      lb_protocol       = listener.value["lb_protocol"]
      instance_port     = listener.value["instance_port"]
      instance_protocol = listener.value["instance_protocol"]
    }
  }
  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    target              = var.target
    interval            = var.interval
  }
  tags = var.tags
}
