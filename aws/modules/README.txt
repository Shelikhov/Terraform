Terraform modules for AWS

ec2-module:
	components:
		- key pair (for EC2 instances)
		- security group (that we can apply to EC2 instances)
		- launch template for ec2 instances
		- auto scaling group
		- random string (to generate prefix for security group)
