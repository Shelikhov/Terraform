output "eks_cluster_name" {
  value = module.eks_project.eks_cluster_name
}

output "master_nodes_subnet_ids" {
  value = module.eks_project.master_nodes_subnet_ids
}

output "worker_nodes_subnet_ids" {
  value = module.eks_project.worker_nodes_subnet_ids
}

output "node_group_name" {
  value = module.eks_project.node_group_name
}
