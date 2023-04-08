#=============================================
#               OUTPUT
#=============================================


output "security_group_name" {
  value = module.asg_project.security_group_name
}

output "launch_template" {
  value = module.asg_project.launch_template
}

output "autoscaling_group_id" {
  value = module.asg_project.autoscaling_group_id
}
