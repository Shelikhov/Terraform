### Common ###

variable "project_name" {
  default = "web-server-linux"
}

variable "tags" {
  type = map(any)
  default = {
    project_name = "web_server_linux"
    environment  = "dev"
  }
}



### Network Dependencies ###

variable "state_storage_type" {
  default = "s3"
}

variable "s3_bucket_name" {
  default = ""
}

# Object name in a bucket
variable "s3_key_path" {
  default = ""
}

variable "aws_region" {
  default = "us-east-2"
}



### Security Groups ###

variable "sg_ingress_rules" {
  default = [
    {
      port        = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "sg_egress_rules" {
  default = [
    {
      port        = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}



### RDS ###

variable "rds_engine" {
  default = "postgres"
}

variable "rds_storage" {
  default = 20
}

variable "rds_instance_class" {
  default = "db.t3.micro"
}

variable "rds_db_name" {
  default = "dev"
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_db_pass_path" {
  default = "/dev/postgres"
}

variable "rds_db_pass_length" {
  default = 16
}

variable "rds_db_pass_spec_characters" {
  default = "!#"
}

variable "rds_db_username" {
  default = "username"
}
