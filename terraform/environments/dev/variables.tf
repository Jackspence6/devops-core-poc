variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# ECR
# variable "ecr_repository_name" {
#   description = "ECR repository name for dev environment"
#   type        = string
# }

# ECS
# variable "ecs_cluster_name" {
#   description = "The name of the ECS cluster for dev environment"
#   type        = string
# }

# IAM
variable "github_repo" {
  description = "GitHub repository in the format username/repo"
  type        = string
  default     = "Jackspence6/finance-tracker-nextjs"
}

variable "dev_user_arn" {
  description = "Your IAM user ARN"
  type        = string
}

variable "github_role_name" {
  description = "Name of the GitHub Actions role"
  type        = string
  default     = "github-actions-role"
}

variable "dev_role_name" {
  description = "Name of the local dev role"
  type        = string
  default     = "dev-ops-ninja"
}
