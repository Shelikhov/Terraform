#=============================================
#               OUTPUT
#=============================================

output "security_group_name" {
  value = module.ec2_project.security_group_name
}
