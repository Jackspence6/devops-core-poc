resource "aws_ecr_repository" "finance_tracker_repository" {
  # Creates a repo in AWS ECR to store our Docker images for deployment to ECS
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_lifecycle_policy" "finance_tracker_lifecycle_policy" {
  # Automatically cleans up old untagged images to save storage and avoid clutter
  repository = aws_ecr_repository.finance_tracker_repository.name
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
