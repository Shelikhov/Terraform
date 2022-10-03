output "aws_region" {
  value = var.aws_region
}

output "availability-zones" {
  value = module.compute_project.availability-zones
}

output "security_group_name" {
  value = module.compute_project.security_group_name
}

output "launch_template" {
  value = module.compute_project.launch_template
}

output "autoscaling_group" {
  value = module.compute_project.autoscaling_group
}

output "elastic_load_balancer" {
  value = module.compute_project.elastic_load_balancer
}

output "rds" {
  value = module.compute_project.rds
}
