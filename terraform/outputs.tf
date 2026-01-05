output "db_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "db_host" {
  description = "The connection host"
  value       = aws_db_instance.postgres.address
}

output "db_name" {
  description = "The database name"
  value       = aws_db_instance.postgres.db_name
}
