#===============================================================
#                  NETWORK RESOURCES
#===============================================================

locals {
  azs = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1]]
}


########################## RESOURCES ##########################

### Custom VPC

resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags                 = var.tags
}


### Custom Subnets

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets)
  availability_zone       = element(local.azs, count.index)
  cidr_block              = element(var.public_subnets, count.index)
  vpc_id                  = aws_vpc.custom_vpc.id
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { availability = "public" })
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnets)
  availability_zone       = element(local.azs, count.index)
  cidr_block              = element(var.private_subnets, count.index)
  vpc_id                  = aws_vpc.custom_vpc.id
  map_public_ip_on_launch = false
  tags                    = merge(var.tags, { availability = "private" })
}


### Internet Gateway

resource "aws_internet_gateway" "custom_internet_gateway" {
  vpc_id = aws_vpc.custom_vpc.id
  tags   = var.tags
}


### Elastic-IP for NAT

resource "aws_eip" "nat_eip" {
  vpc  = true
  tags = var.tags
  depends_on = [
    aws_internet_gateway.custom_internet_gateway
  ]
}


### NAT

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnets.*.id, 0)
  tags          = var.tags
}


### Route Tables

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = var.vpc_routes.destination
    gateway_id = aws_internet_gateway.custom_internet_gateway.id
  }
  tags = merge(var.tags, { availability = "public" })
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block     = var.vpc_routes.destination
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = merge(var.tags, { availability = "private" })
}


### Route table associations

resource "aws_route_table_association" "public_route_associations" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_associations" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}


