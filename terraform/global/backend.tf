terraform {
  backend "s3" {
    bucket         = var.s3_bucket_name
    key            = "devops-core-poc/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
