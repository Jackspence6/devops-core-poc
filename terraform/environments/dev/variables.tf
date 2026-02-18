# ECR
variable "ecr_repository_name" {
  description = "ECR repository name for dev environment"
  type        = string
}

# ECS
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster for dev environment"
  type        = string
}

# IAM
variable "github_repo" {
  description = "GitHub repository in the format username/repo"
  type        = string
  default     = "Jackspence6/finance-tracker-nextjs"
}

variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string
  default     = "dev-role"
}
