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

# VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "vpc_azs" {
  description = "Availability zones"
  type        = list(string)
}

# RDS VARIABLES
variable "db_name_prefix" {
  description = "Name prefix for RDS resources"
  type        = string
}

variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage (GB)"
  type        = number
}

variable "db_engine_version" {
  description = "Postgres engine version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance size"
  type        = string
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "ecs_security_groups" {
  description = "Security groups allowed to access RDS"
  type        = list(string)
}

variable "db_multi_az" {
  description = "Enable multi-AZ deployment"
  type        = bool
}

variable "db_backup_retention" {
  description = "Backup retention period (days)"
  type        = number
}

# COMMON TAGS
variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}
