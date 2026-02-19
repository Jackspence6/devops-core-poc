variable "aws_region" {
  description = "AWS region for all environments"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "S3 bucket for Terraform state"
  type        = string
}
