output "vpc-id" {
  value = data.aws_vpc.web_server_linux_vpc.id
}

output "custom_public_subnets" {
  value = [aws_subnet.public_subnets[0], aws_subnet.public_subnets[1].id]
}

output "custom_private_subnets" {
  value = [aws_subnet.private_subnets[0].id, aws_subnet.private_subnets[1].id]
}

output "availability-zones" {
  value = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1]]
}

output "internet_gateway_id" {
  value = data.aws_internet_gateway.gateway.internet_gateway_id
}

output "public_route_table" {
  value = aws_route_table.public_route_table.id
}

output "private_route_table" {
  value = aws_route_table.private_route_table.id
}
