variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "image_url" {
  description = "The URL of the Docker image to deploy"
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "listener_arn" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  type        = string
}
