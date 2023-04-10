Project to deploy compute modules

Prerequisites:
- to complete details about s3 bucket where will be terraform state in remote_state.tf file for the following parameters:
  - bucket
  - key
  - region
- to edit nessasery variables in variables.tf file
  - file_user_data
  - ec2_file_ssh_id_rsa_path
  - s3_bucket_name

AWS components:
  - Autoscaling Group for master nodes
  - Autoscaling Group for worker nodes
  - Loadbalancer for master nodes
  - bastion host
