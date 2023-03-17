Infrastructure with compute resources

1.To replace path to an id_rsa key to connect to ec2 instances in variables.tf file, parameter ec2_file_ssh_id_rsa_path
2.To replace path to a server script file in variables.tf file parameter file_user_data

AWS components:
- key pair (for EC2 instances)
- security group (that we can apply to EC2, RDS, Elastic Load Balancer)
- launch template for ec2 instances
- auto scaling group
- random string (security group name prefix)
