#=============================================
#                 RESOURCES
#=============================================


### Security Group ###

resource "aws_security_group" "security_group" {
  name   = "${var.project_name}-${random_string.sg_name_prefix.result}"
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




################### EC2 resources #########################

### Key Pair ###

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = try(var.ec2_ssh_key_name, var.project_name)
  public_key = file("${var.ec2_file_ssh_key_path}")
  tags       = var.tags
}

### EC2 Instance ###

resource "aws_instance" "ec2_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key_pair.key_name
  user_data              = var.file_user_data #filebase64("${var.file_user_data}")
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id              = var.subnet_id
  tags                   = var.tags
}
