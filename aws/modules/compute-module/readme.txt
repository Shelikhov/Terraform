Infrastructure with compute resources for web server and RDS

1.To replace path to an id_rsa key to connect to ec2 instances in variables.tf file, parameter file_ssh_id_rsa
2.To replace path to a web-server script file in variables.tf file parameter file_user_data
3.To replace s3 bucket information in following files: 
- dependencies.tf

AWS components:
- key pair (for EC2 instances)
- security group (that we can apply to EC2, RDS, Elastic Load Balancer)
- launch template for ec2 instances
- auto scaling group
- classic load balancer
- RDS (PostgreSQL)
- SSM Parameter (to store db password)
- random string (to generate random db password)
