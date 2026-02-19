variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for storing Terraform state files"
  type        = string
}
