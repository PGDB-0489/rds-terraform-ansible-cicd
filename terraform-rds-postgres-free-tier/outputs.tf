output "rds_endpoint" {
  value       = module.postgres.endpoint
  description = "RDS endpoint (host)"
}

output "rds_port" {
  value       = module.postgres.port
  description = "RDS port"
}

output "rds_username" {
  value       = module.postgres.username
  description = "RDS master username"
}

output "namespace" {
  value       = module.postgres.project
  description = "Project/Environment namespace"
  
}

output "db_secret_version" {
  value       = module.postgres.db_secret_version
  description = "RDS secret version"
  
}

output "rds_dbname" {
  value       = module.postgres.db_name
  description = "RDS database name"
}

