#=============================================
#               OUTPUT
#=============================================

output "elb_security_group_name" {
  value = aws_security_group.elb_security_group.name
}

output "elastic_load_balancer" {
  value = {
    name = aws_elb.loadbalancer.name
    id   = aws_elb.loadbalancer.id
    arn  = aws_elb.loadbalancer.arn
  }
}
