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
  name   = var.project_name
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




################### RDS resources #########################

### RDS

resource "aws_db_instance" "postgresql" {
  identifier             = var.project_name
  engine                 = var.rds_engine
  allocated_storage      = var.rds_storage
  instance_class         = var.rds_instance_class
  db_name                = var.rds_db_name
  username               = var.rds_db_username
  password               = random_string.rds_password.result
  storage_type           = var.rds_storage_type
  skip_final_snapshot    = true
  apply_immediately      = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  publicly_accessible    = false
  #  multi_az = false
  tags = var.tags
}

### RDS credentials

resource "random_string" "rds_password" {
  length           = var.rds_db_pass_length
  special          = true
  override_special = var.rds_db_pass_spec_characters
  lower            = true
  upper            = true
}

###Credential storage

resource "aws_ssm_parameter" "rds_password" {
  name  = var.rds_db_pass_path
  type  = "SecureString"
  value = random_string.rds_password.result
}

### RDS Subnet Group

resource "aws_db_subnet_group" "rds_subnet" {
  name       = var.project_name
  subnet_ids = local.network.custom_public_subnet_ids
  tags       = var.tags
}
