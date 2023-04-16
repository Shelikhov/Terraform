#=============================================
#               VARIABLES
#=============================================

### Common variables ###

#Only alphanumeric value for ELB
variable "project_name" {
  default = "custom"
}

variable "aws_region" {
  default = "us-east-2"
}





### Variables for Network dependencies ###

variable "state_storage_type" {
  default = "s3"
}

variable "s3_bucket_name" {
  default = "" # Bucket name for the network module
}

variable "s3_key_path" {
  default = "terraform/projects/network_project"
}





### ELB ###

#6443: kubernetes api server
variable "elb_sg_ingress_rules" {
  default = [
    {
      port        = 6443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "lb_listeners" {
  default = [
    {
      lb_port           = "6443"
      lb_protocol       = "TCP"
      instance_port     = "6443"
      instance_protocol = "TCP"
    }
  ]
}

variable "lb_health_check" {
  default = [
    {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
      target              = "TCP:6443"
      interval            = 20
    }
  ]
}





### Variables for Etcd instances ###

variable "etcd_node_file_user_data" {
  default = "" # Script for ec2 initializing
}

variable "etcd_ec2_ssh_key_name" {
  default = "k8s_etcd_node" # SSH key location to get access to ec2 instances
}

variable "etcd_ec2_ssh_key_path" {
  default = "" # SSH key location to get access to ec2 instances
}

variable "etcd_launch_template_name" {
  default = "etcd_launch_template"
}

variable "etcd_asg_name" {
  default = "etcd_asg"
}

variable "etcd_instance_type" {
  default = "t3.small"
}

#ami-00eeedc4036573771: Ubuntu-22.04
#ami-0568936c8d2b91c4e: Ubuntu-20.04
#ami-02238ac43d6385ab3: Amazon linux
#ami-067a8829f9ae24c1c: RHEL 9
variable "etcd_instance_image_id" {
  default = "ami-00eeedc4036573771"
}

variable "etcd_instance_min_count" {
  default = 0
}

variable "etcd_instance_max_count" {
  default = 2
}

variable "etcd_instance_desired_count" {
  default = 2
}

variable "etcd_termination_policies" {
  default = ["NewestInstance"]
}

#22:   ssh
#2379: for client requests
#2380: for peer communication
variable "etcd_sg_ingress_rules" {
  default = [
    {
      port        = 22
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
    }
  ]
}





### Variables master instances ###

variable "master_node_file_user_data" {
  default = "" # Script for ec2 initializing
}

variable "master_ec2_ssh_key_name" {
  default = "k8s_master_node" # SSH key location to get access to ec2 instances
}

variable "master_ec2_ssh_key_path" {
  default = "" # SSH key location to get access to ec2 instances
}

variable "master_launch_template_name" {
  default = "master_launch_template"
}

variable "master_asg_name" {
  default = "master_asg"
}

variable "master_instance_type" {
  default = "t3.small"
}

#ami-00eeedc4036573771: Ubuntu-22.04
#ami-0568936c8d2b91c4e: Ubuntu-20.04
#ami-02238ac43d6385ab3: Amazon linux
#ami-0103f211a154d64a6: Amazon Linux 2023
#ami-067a8829f9ae24c1c: RHEL 9
variable "master_instance_image_id" {
  default = "ami-00eeedc4036573771"
}

variable "master_instance_min_count" {
  default = 0
}

variable "master_instance_max_count" {
  default = 2
}

variable "master_instance_desired_count" {
  default = 2
}

variable "master_termination_policies" {
  default = ["NewestInstance"]
}

#22: 		ssh
#6443: 		kubernetes api server
#2379:		etcd for client requests
#2380:		etcd for peer communication
#10250: 	kubelet 
#10259: 	kube-scheduler
#10257: 	kube-controller-manager
#179: 		Calico BGP
#4789: 		Calico VXLAN
#5473: 		Calico Typha
variable "master_sg_ingress_rules" {
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





### Variables for worker instances ###

variable "worker_node_file_user_data" {
  default = "" # Script for ec2 initializing
}

variable "worker_ec2_ssh_key_name" {
  default = "k8s_worker_node" # SSH key location to get access to ec2 instances
}

variable "worker_ec2_ssh_key_path" {
  default = "" # SSH key location to get access to ec2 instances
}

variable "worker_launch_template_name" {
  default = "worker_launch_template"
}

variable "worker_asg_name" {
  default = "worker_asg"
}

variable "worker_instance_type" {
  default = "t3.small"
}

#ami-00eeedc4036573771: Ubuntu-22.04
#ami-0568936c8d2b91c4e: Ubuntu-20.04
#ami-02238ac43d6385ab3: Amazon linux
#ami-0103f211a154d64a6: Amazon Linux 2023
#ami-067a8829f9ae24c1c: RHEL 9
variable "worker_instance_image_id" {
  default = "ami-00eeedc4036573771"
}

variable "worker_instance_min_count" {
  default = 0
}

variable "worker_instance_max_count" {
  default = 1
}

variable "worker_instance_desired_count" {
  default = 1
}

variable "worker_termination_policies" {
  default = ["NewestInstance"]
}

variable "worker_sg_ingress_rules" {
  default = [
    {
      port        = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}



### Variables for bastion instance ###

variable "bastion_file_user_data" {
  default = "" # Script for ec2 initializing
}

variable "bastion_ec2_ssh_key_name" {
  default = "k8s_bastion_node" # SSH key location to get access to ec2 instances
}

variable "bastion_ec2_ssh_key_path" {
  default = "" # SSH key location to get access to ec2 instances
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

#ami-00eeedc4036573771: Ubuntu-22.04
#ami-0568936c8d2b91c4e: Ubuntu-20.04
#ami-02238ac43d6385ab3: Amazon linux
#ami-0103f211a154d64a6: Amazon Linux 2023
#ami-067a8829f9ae24c1c: RHEL 9
variable "bastion_ami" {
  default = "ami-0103f211a154d64a6"
}

variable "bastion_sg_ingress_rules" {
  default = [
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "bastion_sg_egress_rules" {
  default = [
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
