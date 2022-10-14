output "availability-zones" {
  value = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1]]
}

output "security_group_name" {
  value = aws_security_group.my_security_group.name
}

output "launch_template" {
  value = {
    name = aws_launch_template.ec2_linux_template.name
    id   = aws_launch_template.ec2_linux_template.id
  }
}

output "autoscaling_group" {
  value = aws_autoscaling_group.ec2_ASG.id
}

output "elastic_load_balancer" {
  value = {
    name = aws_elb.web_server_loadbalancer.name
    id   = aws_elb.web_server_loadbalancer.id
    arn  = aws_elb.web_server_loadbalancer.arn
  }
}
