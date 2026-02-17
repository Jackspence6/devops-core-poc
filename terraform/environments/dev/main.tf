# ECR
module "ecr" {
  source              = "../../modules/ecr"
  ecr_repository_name = var.ecr_repository_name
}

# ECS
module "ecs" {
  source         = "../../modules/ecs"
  cluster_name   = var.ecs_cluster_name
  image_url      = module.ecr.repository_url
  container_port = 80
  subnet_ids     = module.vpc.public_subnets
}

