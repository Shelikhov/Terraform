Infrastructure with compute and network resources for web server and RDS

Launch order:
1. state_storage
2. vpc_project
3. compute_project



AWS components:

Storage for project state:
- s3 bucket

Network resources:
- custom vpc
- custom subnets (2 public and 2 private)
- route tables with access to the internet
- internet gateway

Compute resources:
- key pair (for EC2 instances)
- security group (that we can apply to EC2, RDS, Elastic Load Balancer)
- launch template for ec2 instances
- auto scaling group
- classic load balancer
- RDS (PostgreSQL)
- SSM Parameter (to store db password)
- random string (to generate random db password)
