variable "github_repo" {
  description = "GitHub repository in the format username/repo"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string
  default     = "dev-role"
}
