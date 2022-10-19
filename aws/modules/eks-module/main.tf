#=============================================
#           COMPUTE RESOURCES
#=============================================

locals {
  network = data.terraform_remote_state.network.outputs
}



################# RESOURCES ###################

### EKS Cluster

resource "aws_eks_cluster" "eks_cluster" {
  name     = local.network.project_name
  role_arn = data.aws_iam_role.eks_iam_role.arn
  vpc_config {
    subnet_ids = local.network.custom_private_subnet_ids
  }
  tags = var.tags
}

### EKS Node Group

resource "aws_eks_node_group" "eks_node_group" {
  node_group_name = local.network.project_name
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_role_arn   = data.aws_iam_role.eks_node_group_iam_role.arn
  scaling_config {
    desired_size = var.scaling_config_desired
    max_size     = var.scaling_config_max
    min_size     = var.scaling_config_min
  }
  subnet_ids     = local.network.custom_public_subnet_ids
  ami_type       = var.instance_image_id
  instance_types = var.instance_types
  remote_access {
    ec2_ssh_key = aws_key_pair.ec2_key_pair.key_name
  }
  tags = var.tags
}

### Key Pair

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = local.network.project_name
  public_key = file("${var.ec2_file_ssh_id_rsa_path}")
  tags       = var.tags
}
