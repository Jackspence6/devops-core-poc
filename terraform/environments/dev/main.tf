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

# VPC
module "vpc" {
  source                = "../../modules/vpc"
  cidr_block            = var.vpc_cidr_block
  public_subnets_cidrs  = var.vpc_public_subnets
  private_subnets_cidrs = var.vpc_private_subnets
  azs                   = var.vpc_azs
  tags                  = var.common_tags
}

# RDS
# module "rds" {
#   source              = "../../modules/rds"
#   name                = var.db_name_prefix
#   db_identifier       = var.db_identifier
#   allocated_storage   = var.db_allocated_storage
#   engine_version      = var.db_engine_version
#   instance_class      = var.db_instance_class
#   db_name             = var.db_name
#   db_username         = var.db_username
#   db_password         = var.db_password
#   subnet_ids          = module.vpc.private_subnets
#   vpc_id              = module.vpc.vpc_id
#   ecs_security_groups = var.ecs_security_groups
#   multi_az            = var.db_multi_az
#   backup_retention    = var.db_backup_retention
#   tags                = var.common_tags
# }
