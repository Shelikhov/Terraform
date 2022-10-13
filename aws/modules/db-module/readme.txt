Module for Database resource (RDS)

1.To complete values for the following variables:
 - s3_bucket_name
 - s3_key_path		# Object name in S3 bucket where the information about Network module is stored
 - rds_db_name
 - rds_db_username

AWS components:
- security group (that we can apply to EC2, RDS, Elastic Load Balancer)
- RDS (PostgreSQL)
- SSM Parameter (to store db password)
- random string (to generate random db password)
