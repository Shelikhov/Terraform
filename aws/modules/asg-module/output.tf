#=============================================
#               OUTPUT
#=============================================

output "security_group_name" {
  value = aws_security_group.security_group.name
}

output "launch_template" {
  value = {
    name = aws_launch_template.ec2_linux_template.name
    id   = aws_launch_template.ec2_linux_template.id
  }
}

output "autoscaling_group_id" {
  value = aws_autoscaling_group.ec2_ASG.id
}

#output "instance_network_interface_id" {
#  value = aws_network_interface.net_interface.id
#}

#output "instance_public_ip" {
#  value = aws_eip.eip.public_ip
#}
