output "endpoint" {
  value = aws_db_instance.postgres.address
}

output "port" {
  value = aws_db_instance.postgres.port
}

output "username" {
  value = aws_db_instance.postgres.username
}

output "project" {
  value = var.project
  
}

output "namespace" {
  value = "${var.project}-${var.environment}"
  
}

output "db_secret_version" {
  value = var.db_secret_version
  
}

output "db_name" {
  value = var.db_name
  
}
/*output "password" {
  value     = var.db_password != "" ? var.db_password : random_password.db_password.result
  sensitive = true
  
}
*/