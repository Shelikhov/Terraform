output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "master_nodes_subnet_ids" {
  value = aws_eks_cluster.eks_cluster.vpc_config[*]
}

output "node_group_name" {
  value = aws_eks_node_group.eks_node_group.node_group_name
}

output "worker_nodes_subnet_ids" {
  value = aws_eks_node_group.eks_node_group.subnet_ids
}

output "cni_addon_name" {
  value = var.cni_addon_name
}

output "cni_addon_version" {
  value = var.cni_addon_version
}
