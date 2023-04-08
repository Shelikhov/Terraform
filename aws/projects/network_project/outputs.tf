#======================================================
#                       OUTPUT
#======================================================

output "project_name" {
  value = module.network_project.project_name
}

output "aws_region" {
  value = var.aws_region
}

output "vpc_id" {
  value = module.network_project.vpc_id
}

output "custom_public_subnet_ids" {
  value = module.network_project.custom_public_subnet_ids
}

output "custom_private_subnet_ids" {
  value = module.network_project.custom_private_subnet_ids
}

output "availability-zones" {
  value = module.network_project.availability-zones
}

output "internet_gateway_id" {
  value = module.network_project.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.network_project.nat_gateway_id
}

output "public_route_table" {
  value = module.network_project.public_route_table
}

output "private_route_table" {
  value = module.network_project.private_route_table
}
