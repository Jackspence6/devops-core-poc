# The full URL of the repo (used for tagging & pushing Docker images)
output "repository_url" {
  value       = aws_ecr_repository.finance_tracker_repository.repository_url
  description = "The URL of the ECR repository for Docker image pushes and pulls"
}

# The Amazon Resource Name (ARN) of the ECR repository
output "repository_arn" {
  value       = aws_ecr_repository.finance_tracker_repository.arn
  description = "The ARN of the ECR repository"
}
