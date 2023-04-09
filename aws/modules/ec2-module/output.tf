#=============================================
#               OUTPUT
#=============================================

output "security_group_name" {
  value = aws_security_group.security_group.name
}
