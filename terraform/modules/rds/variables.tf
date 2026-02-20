variable "name" {
  description = "Module name prefix"
  type        = string
}

variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "allocated_storage" {
  description = "Storage in GB"
  type        = number
}

variable "engine_version" {
  description = "Postgres engine version"
  type        = string
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for RDS"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ecs_security_groups" {
  description = "Security groups for ECS tasks to connect to RDS"
  type        = list(string)
  default     = []
}

variable "multi_az" {
  description = "Enable multi-AZ"
  type        = bool
  default     = false
}

variable "backup_retention" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags for RDS"
  type        = map(string)
  default     = {}
}
