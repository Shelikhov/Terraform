#=============================================
#           COMPUTE RESOURCES
#=============================================

locals {
  azs = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1]]
  network = data.terraform_remote_state.network.outputs
}



################# RESOURCES ###################

### Security Group

resource "aws_security_group" "my_security_group" {
  name = var.project_name
  vpc_id = local.network.vpc_id

  dynamic "ingress" {
    for_each = var.instance_ingress_ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = var.instance_ingress_protocol
      cidr_blocks = var.instance_ingress_cidr
    }
  }

  dynamic "egress" {
    for_each = var.instance_egress_ports
    content {
      from_port = egress.value
      to_port = egress.value
      protocol = var.instance_egress_protocol
      cidr_blocks = var.instance_egress_cidr
    }
  }
  tags = var.tags
}




################### EC2 resources #########################

### Key Pair

resource "aws_key_pair" "ec2_key_pair" {
  key_name = var.project_name
  public_key = file("${var.file_ssh_id_rsa}")
  tags = var.tags
}

### Launch Template

resource "aws_launch_template" "ec2_linux_template" {
  name = var.project_name
  image_id = var.instance_image_id
  instance_type = var.instance_type
#  security_group_names = [aws_security_group.my_security_group.name] #Only one security_group_names or vpc_security_group_ids we can specify
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name = aws_key_pair.ec2_key_pair.key_name
  user_data = filebase64("${var.file_user_data}")
  tags = var.tags
  depends_on = [aws_db_instance.postgresql]
}

### Auto Scaling Group

resource "aws_autoscaling_group" "ec2_ASG" {
  max_size = var.instance_max_count
  min_size = var.instance_min_count
  desired_capacity = var.instance_desired_count
  launch_template {
    id = aws_launch_template.ec2_linux_template.id
  }
#  availability_zones = local.azs #Conflicts with vpc_zone_identifier
  vpc_zone_identifier = local.network.custom_public_subnet_ids
  load_balancers = [aws_elb.web_server_loadbalancer.name]
}

################### ELB resources #########################

### Elastic Load Balancer

resource "aws_elb" "web_server_loadbalancer" {
  name = var.project_name
#  availability_zones = local.azs[*] #Conflicts with subnets
  subnets = local.network.custom_public_subnet_ids
  security_groups = [aws_security_group.my_security_group.id]
  dynamic "listener" {
    for_each = var.lb_ports
    content {
      lb_port = listener.value
      lb_protocol = "http"
      instance_port = listener.value
      instance_protocol = "http"
    }
  }
  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout = var.timeout
    target = var.target
    interval = var.interval
  }
  tags = var.tags
}

################### RDS resources #########################

### RDS

resource "aws_db_instance" "postgresql" {
  identifier = var.project_name
  engine = var.rds_engine
  allocated_storage = var.rds_storage
  instance_class = var.rds_instance_class
  db_name = var.rds_db_name
  username = var.rds_db_username
  password = random_string.rds_password.result
  storage_type = var.rds_storage_type
  skip_final_snapshot = true
  apply_immediately = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  publicly_accessible = false
#  multi_az = false
  tags = var.tags
}

### RDS credentials

resource "random_string" "rds_password" {
  length = var.rds_db_pass_length
  special = true
  override_special = var.rds_db_pass_spec_characters
  lower = true
  upper = true
}

###Credential storage

resource "aws_ssm_parameter" "rds_password" {
  name = var.rds_db_pass_path
  type = "SecureString"
  value = random_string.rds_password.result
}

### RDS Subnet Group

resource "aws_db_subnet_group" "rds_subnet" {
  name = var.project_name
  subnet_ids = local.network.custom_private_subnet_ids
  tags = var.tags
}
