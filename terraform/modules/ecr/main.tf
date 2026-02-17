resource "aws_ecr_repository" "this" {
  # Creates a repo in AWS ECR to store our Docker images for deployment to ECS
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_lifecycle_policy" "this" {
  # Automatically cleans up old untagged images to save storage and avoid clutter
  repository = aws_ecr_repository.this.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire old images"
        selection    = { tagStatus = "untagged", countType = "imageCountMoreThan", countNumber = 10 }
        action       = { type = "expire" }
      }
    ]
  })
}
