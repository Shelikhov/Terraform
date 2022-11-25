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
  name                   = var.project_name
  image_id               = var.instance_image_id
  instance_type          = var.instance_type
#  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name               = aws_key_pair.ec2_key_pair.key_name
  user_data              = filebase64("${var.file_user_data}")
  network_interfaces {
    network_interface_id   = aws_network_interface.net_interface.id
    associate_public_ip_address = true
    security_groups = [aws_security_group.my_security_group.id]
    subnet_id = local.network.custom_public_subnet_ids[0]
  }
  tags                   = var.tags
}

### Auto Scaling Group

resource "aws_autoscaling_group" "ec2_ASG" {
  name             = var.project_name
  max_size         = var.instance_max_count
  min_size         = var.instance_min_count
  desired_capacity = var.instance_desired_count
  launch_template {
    id = aws_launch_template.ec2_linux_template.id
  }
  vpc_zone_identifier = local.network.custom_public_subnet_ids
}

### TEST ###

resource "aws_network_interface" "net_interface" {
  subnet_id   = local.network.custom_public_subnet_ids[0]
  description = var.project_name
  tags        = var.tags
}

resource "aws_eip" "eip" {
  network_interface = aws_network_interface.net_interface.id
  tags              = var.tags
}
#  security_groups = [aws_security_group.my_security_group.id]
