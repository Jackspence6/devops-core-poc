# ECR
# module "ecr" {
#   source              = "../../modules/ecr"
#   ecr_repository_name = var.ecr_repository_name
# }

# ECS
# module "ecs" {
#   source         = "../../modules/ecs"
#   cluster_name   = var.ecs_cluster_name
#   image_url      = module.ecr.repository_url
#   container_port = 80
#   subnet_ids     = module.vpc.public_subnets
# }

# IAM
module "iam" {
  source           = "../../modules/iam"
  github_repo      = var.github_repo
  dev_user_arn     = var.dev_user_arn
  github_role_name = var.github_role_name
  dev_role_name    = var.dev_role_name
}
