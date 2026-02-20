# ECR Repository
resource "aws_ecr_repository" "this" {
  # Creates a repo in AWS ECR to store our Docker images for ECS
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"
}

# Lifecycle Policy
resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images beyond 10"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
