output "availability-zones" {
  value = [data.aws_availability_zones.azs.names[0], data.aws_availability_zones.azs.names[1]]
}

output "security_group_name" {
  value = aws_security_group.my_security_group.name
}

output "rds" {
  value = {
    id     = aws_db_instance.postgresql.id
    engine = aws_db_instance.postgresql.engine
    arn    = aws_db_instance.postgresql.arn
  }
}
