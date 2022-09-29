provider "aws"{
  region = var.region
}



data "aws_vpc" "web_server_linux_vpc" {}
data "aws_availability_zones" "azs" {
  state = "available"
}
data "aws_internet_gateway" "gateway" {
  filter {
    name = "attachment.vpc-id"
    values = [data.aws_vpc.web_server_linux_vpc.id]
  }
}


locals {
  azs = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1], data.aws_availability_zones.azs.names[2]]
}




### Custom Subnets

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)
  availability_zone = element(local.azs, count.index)
  cidr_block = element(var.public_subnets, count.index)
  vpc_id = data.aws_vpc.web_server_linux_vpc.id
  map_public_ip_on_launch = true
  tags = merge(var.tags, {availability="public"})
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)
  availability_zone = element(local.azs, count.index)
  cidr_block = element(var.private_subnets, count.index)
  vpc_id = data.aws_vpc.web_server_linux_vpc.id
  map_public_ip_on_launch = true
  tags = merge(var.tags, {availability="private"})
}


### Route Tables

resource "aws_route_table" "public_route_table" {
  vpc_id = data.aws_vpc.web_server_linux_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.gateway.internet_gateway_id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = data.aws_vpc.web_server_linux_vpc.id
}

resource "aws_route_table_association" "public_route_associations" {
  count = length(var.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_associations" {
  count = length(var.private_subnets)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}




###KEY PAIR

resource "aws_key_pair" "ec2_key_pair" {
  key_name = var.project_name
  public_key = file("${var.file_ssh_id_rsa}")
  tags = var.tags
}




###SECURITY GROUP

resource "aws_security_group" "my_security_group" {
  name = var.project_name
  vpc_id = data.aws_vpc.web_server_linux_vpc.id

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



###Launch Template

resource "aws_launch_template" "ec2_linux_template" {
  name = var.project_name
  image_id = var.instance_image_id
  instance_type = var.instance_type
#  security_group_names = [aws_security_group.my_security_group.name]
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name = aws_key_pair.ec2_key_pair.key_name
  user_data = filebase64("${var.file_uaer_data}")
  tags = var.tags
  depends_on = [aws_db_instance.postgresql]
}



###Auto Scaling Group

resource "aws_autoscaling_group" "ec2_ASG" {
  max_size = var.instance_max_count
  min_size = var.instance_min_count
  desired_capacity = var.instance_desired_count
  launch_template {
    id = aws_launch_template.ec2_linux_template.id
  }
#  availability_zones = local.azs #Conflicts with vpc_zone_identifier
  vpc_zone_identifier = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id]
  load_balancers = [aws_elb.web-server-loadbalancer.name]
}



###Elastic Load Balancer

resource "aws_elb" "web-server-loadbalancer" {
  name = var.project_name
  availability_zones = [local.azs[0], local.azs[1]]
#  subnets = [data.aws_subnets.subnets.ids[0], data.aws_subnets.subnets.ids[1]]
  dynamic "listener" {
    for_each = var.lb_ports
    content {
      lb_port = listener.value
      lb_protocol = "http"
      instance_port = listener.value
      instance_protocol = "http"
    }
  }
  tags = var.tags
}




### RDS

resource "aws_db_instance" "postgresql" {
  identifier = var.project_name
  engine = "postgres"
  allocated_storage = 20
  instance_class = "db.t3.micro"
  db_name = "dev"
  username = "Standart"
  password = "Standart"
  storage_type = "gp2"
  skip_final_snapshot = true
  apply_immediately = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  publicly_accessible = true
#  multi_az = false
  tags = var.tags
}


### RDS Subnet Group

resource "aws_db_subnet_group" "rds_subnet" {
  name = var.project_name
  subnet_ids = [aws_subnet.private_subnets[0].id, aws_subnet.private_subnets[1].id]
  tags = var.tags
}



### Deafault Subnets

#data "aws_subnet" "public_subnet" {
#  filter {
#    name = "availability-zone"
#    values = [local.azs[0]]
#  }
#}
#data "aws_subnets" "private_subnets" {
#  filter {
#    name = "availability-zone"
#    values = [local.azs[1], local.azs[2]]
#  }
#}
