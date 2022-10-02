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

variable "bucket_prefix_length" {
  default = 5
}
