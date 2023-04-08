#=============================================
#               VARIABLES
#=============================================

variable "project_name" {
  default = "custom"
}

variable "aws_region" {
  default = "us-east-2"
}

variable "file_user_data" {
  default = "" # Script for ec2 initializing
}

variable "ec2_file_ssh_id_rsa_path" {
  default = "" # SSH key location to get access to ec2 instances
}

variable "state_storage_type" {
  default = "s3"
}

variable "s3_bucket_name" {
  default = "" # Bucket name for the network module
}

variable "s3_key_path" {
  default = "terraform/projects/network_project"
}

#ami-00eeedc4036573771: Ubuntu-22.04
#ami-0568936c8d2b91c4e: Ubuntu-20.04
#ami-02238ac43d6385ab3: Amazon linux
#ami-067a8829f9ae24c1c: RHEL 9
variable "instance_image_id" {
  default = "ami-00eeedc4036573771"
}

variable "instance_type" {
  default = "t3.small"
}

variable "instance_desired_count" {
  default = 1
}

variable "termination_policies" {
  default = ["NewestInstance"]
}

#22: ssh
#6443: kubernetes api server
#2379-2380: kube-apiserver, etcd
#10250: kubelet 
#10259: kube-scheduler
#10257: kube-controller-manager
#179: Calico BGP
#4789: Calico VXLAN
#5473: Calico Typha
variable "sg_ingress_rules" {
  default = [
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 6443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 2379
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 2380
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 10250
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 10259
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 10257
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 179
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 4789
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 5473
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
