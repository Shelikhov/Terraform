#=============================================
#               OUTPUT
#=============================================


output "etcd_nodes_security_group_name" {
  value = module.asg_etcd_nodes.security_group_name
}

output "master_nodes_security_group_name" {
  value = module.asg_master_nodes.security_group_name
}

output "worker_nodes_security_group_name" {
  value = module.asg_worker_nodes.security_group_name
}

output "etcd_nodes_launch_template" {
  value = module.asg_etcd_nodes.launch_template
}

output "master_nodes_launch_template" {
  value = module.asg_master_nodes.launch_template
}

output "worker_nodes_launch_template" {
  value = module.asg_worker_nodes.launch_template
}

output "etcd_nodes_asg_id" {
  value = module.asg_etcd_nodes.autoscaling_group_id
}

output "master_nodes_asg_id" {
  value = module.asg_master_nodes.autoscaling_group_id
}

output "worker_nodes_asg_id" {
  value = module.asg_worker_nodes.autoscaling_group_id
}

output "elb_security_group_name" {
  value = module.loadbalancer.elb_security_group_name
}

output "elastic_load_balancer" {
  value = {
    name = module.loadbalancer.elastic_load_balancer.name
    id   = module.loadbalancer.elastic_load_balancer.id
    arn  = module.loadbalancer.elastic_load_balancer.arn
  }
}
