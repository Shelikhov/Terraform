#=============================================
#               OUTPUT
#=============================================


output "elb_security_group_name" {
  value = module.lb_project.elb_security_group_name
}

output "elastic_load_balancer" {
  value = {
    name = module.lb_project.elastic_load_balancer.name
    id   = module.lb_project.elastic_load_balancer.id
    arn  = module.lb_project.elastic_load_balancer.arn
  }
}
