#=============================================
#               OUTPUT
#=============================================

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "custom_public_subnet_ids" {
  value = aws_subnet.public_subnets[0].id
}

output "custom_private_subnet_ids" {
  value = aws_subnet.private_subnets[0].id
}

output "availability-zones" {
  value = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1]]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.custom_internet_gateway.id
}

output "public_route_table" {
  value = aws_route_table.public_route_table.id
}

output "private_route_table" {
  value = aws_route_table.private_route_table.id
}

#output "security_group_name" {
#  value = aws_security_group.security_group.name
#}
