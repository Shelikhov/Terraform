output "aws_region" {
  value = var.aws_region
}

output "availability-zones" {
  value = module.db_project.availability-zones
}

output "security_group_name" {
  value = module.db_project.security_group_name
}

output "rds" {
  value = module.db_project.rds
}
