output "github_role_arn" {
  description = "ARN of GitHub Actions role"
  value       = aws_iam_role.github_role.arn
}

output "dev_role_arn" {
  description = "ARN of local dev role"
  value       = aws_iam_role.dev_role.arn
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}
