# ECR
module "ecr" {
  source              = "../../modules/ecr"
  ecr_repository_name = var.ecr_repository_name
}

# ECS
module "ecs" {
  source             = "../../modules/ecs"
  cluster_name       = var.ecs_cluster_name
  image_url          = "${module.ecr.repository_url}:latest"
  container_port     = var.container_port
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [aws_security_group.ecs.id]
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  target_group_arn   = module.alb.target_group_arn
  listener_arn       = module.alb.alb_arn
}

resource "aws_security_group" "ecs" {
  name   = "ecs-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id] # allow traffic from ALB
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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
module "rds" {
  source              = "../../modules/rds"
  name                = var.db_name_prefix
  db_identifier       = var.db_identifier
  allocated_storage   = var.db_allocated_storage
  engine_version      = var.db_engine_version
  instance_class      = var.db_instance_class
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  subnet_ids          = module.vpc.private_subnets
  vpc_id              = module.vpc.vpc_id
  ecs_security_groups = var.ecs_security_groups
  multi_az            = var.db_multi_az
  backup_retention    = var.db_backup_retention
  tags                = var.common_tags
}

# ALB
module "alb" {
  source             = "../../modules/alb"
  name               = "finance-tracker-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnets
  security_group_ids = [aws_security_group.alb.id]
  container_port     = var.container_port
  tags               = var.common_tags
}

resource "aws_security_group" "alb" {
  name   = "alb-sg"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
