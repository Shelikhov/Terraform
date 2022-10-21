EKS module

Prerequisites:
1.To replace path to an id_rsa key to connect to worker nodes in variables.tf file, parameter ec2_file_ssh_id_rsa_path

AWS components:
- key pair (to get access to the worker nodes by ssh)
- EKS Cluster (master nodes)
- EKS Node Group (worker nodes)
- EKS Add-on
  - vpc cni
