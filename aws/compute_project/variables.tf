### Common ###

variable "region" {
  default = "us-east-2"
}

variable "project_name" {
  default = "web-server-linux"
}

variable "tags" {
  type = map
  default = {
    project_name = "web_server_linux"
    environment = "dev"
  }
}



### EC2 Instance ###

variable "instance_image_id" {
  default = "ami-0f924dc71d44d23e2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_max_count" {
  default = 3
}

variable "instance_min_count" {
  default = 1
}

variable "instance_desired_count" {
  default = 3
}

variable "instance_ingress_ports" {
  type = list
  default = ["0"]
}

variable "instance_ingress_protocol" {
  default = -1
}

variable "instance_ingress_cidr" {
  type = list
  default = ["0.0.0.0/0"]
}
variable "instance_egress_cidr" {
  type = list
  default = ["0.0.0.0/0"]
}

variable "instance_egress_ports" {
  type = list
  default = ["0"]
}

variable "instance_egress_protocol" {
  default = -1
}

variable "file_ssh_id_rsa" {
  default = "/path_to_id_rsa.pub"
}

variable "file_user_data" {
  default = "webserver-script.sh.tpl"
}



### ELB ###

variable "lb_ports" {
  type = list
  default = ["80"]
}

variable "healthy_threshold" {
  default = 2
}

variable "unhealthy_threshold" {
  default = 2
}

variable "timeout" {
  default = 5
}

variable "target" {
  default = "HTTP:80/"
}

variable "interval" {
  default = 10
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
