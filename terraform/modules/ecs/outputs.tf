# Cluster name
output "cluster_name" {
  value       = aws_ecs_cluster.this.name
  description = "The name of the ECS cluster"
}

# ECS service Amazon Resource Name (ARN)
output "service_arn" {
  value       = aws_ecs_service.this.arn
  description = "The ECS service ARN"
}

# Task definition Amazon Resource Name (ARN)
output "task_definition_arn" {
  value       = aws_ecs_task_definition.this.arn
  description = "The ECS task definition ARN"
}
