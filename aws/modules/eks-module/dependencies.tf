#=============================================
#               DEPENDENCIES
#=============================================

data "terraform_remote_state" "network" {
  backend = var.state_storage_type
  config = {
    bucket = var.s3_bucket_name
    key    = var.s3_key_path
    region = var.aws_region
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}

data "aws_iam_role" "eks_iam_role" {
  name = "eksClusterRole"
  tags = {
    service = "eks"
  }
}

data "aws_iam_role" "eks_node_group_iam_role" {
  name = "eks_node_group"
  tags = {
    service = "eks"
  }
}
