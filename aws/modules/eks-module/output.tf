output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "master_nodes_subnet_ids" {
  value = aws_eks_cluster.eks_cluster.vpc_config.subnet_ids
}

output "node_group_name" {
  value = aws_eks_node_group.eks_node_group.node_group_name
}

output "worker_nodes_subnet_ids" {
  value = aws_eks_node_group.eks_node_group.subnet_ids
}
