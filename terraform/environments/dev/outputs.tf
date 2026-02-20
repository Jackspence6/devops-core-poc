# ECR
output "repository_url" {
  value       = module.ecr.repository_url
  description = "The URL of the ECR repository from the ECR module"
}

output "repository_arn" {
  value       = module.ecr.repository_arn
  description = "The ARN of the ECR repository from the ECR module"
}

# RDS
output "db_endpoint" {
  value       = module.rds.db_endpoint
  description = "The endpoint of the RDS instance"
}

output "db_port" {
  value       = module.rds.db_port
  description = "The port of the RDS instance"
}
