variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment"
  default     = "production"
}

variable "db_name" {
  description = "Database name"
  default     = "techchallenge" # Matches your application.yml
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
  default     = "postgres"
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
  default     = "defaultpassword"
}
