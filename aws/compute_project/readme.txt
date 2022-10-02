Infrastructure with compute resources for web server and RDS

1.To replace path to an id_rsa key to connect to ec2 instances
2.To replace s3 bucket name in following files: 
- main.tf
- remote_state.tf 

AWS components:
- key pair (for EC2 instances)
- security group (that we can apply to EC2, RDS, Elastic Load Balancer)
- launch template for ec2 instances
- auto scaling group
- classic load balancer
- RDS (PostgreSQL)
- SSM Parameter (to store db password)
- random string (to generate random db password)
