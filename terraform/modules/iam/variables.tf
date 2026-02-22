# GitHub Config
variable "github_repo" {
  description = "GitHub repo in format username/repo"
  type        = string
}

variable "github_role_name" {
  description = "Name of GitHub IAM role"
  type        = string
  default     = "github-actions-role"
}

# Dev Role Config
variable "dev_role_name" {
  description = "Name of local dev IAM role"
  type        = string
  default     = "dev-ops-ninja"
}

variable "dev_user_arn" {
  description = "Your IAM user ARN"
  type        = string
}

# ECS Task Execution Role
variable "ecs_task_execution_role_name" {
  description = "Name of ECS task execution role"
  type        = string
  default     = "ecsTaskExecutionRole"
}
