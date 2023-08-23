# Terraform provider block that are required
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.1"
    }
  }

  required_version = ">= 1.1.7"
}

# Provides a KMS customer master key
resource "aws_kms_key" "kms_key" {
  description         = "KMS ECS key"
  enable_key_rotation = true
}

# Key policy for KMS key
resource "aws_kms_key_policy" "example" {
  key_id = aws_kms_key.kms_key.arn
  policy = jsonencode({
    Id = "example"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}

# Module for creating VPC and subnets
module "vpc_network" {
  source = "./modules/vpc_network"

  subnet_count        = var.subnet_count
  vpc_cidr_block      = var.vpc_cidr_block
  flow_logs_group_arn = module.cw_logs.flow_log_group
}

# Module for VPC endpoints
module "vpc_endpoints" {
  source = "./modules/vpc_endpoints"

  vpc_id     = module.vpc_network.vpc_id
  aws_region = var.aws_region
  # route_table_ids             = module.vpc_network.subnet_rts.*.id
  route_table_ids             = [for rt in module.vpc_network.subnet_rts : rt.id]
  subnet_ids_ecr_cw           = [for count in range(length(module.vpc_network.subnets)) : module.vpc_network.subnets[count].id if count < var.subnet_count && count < module.vpc_network.az_list]
  subnet_ids_ssm_ec2_kms      = [for count in range(length(module.vpc_network.subnets)) : module.vpc_network.subnets[count].id if count > (var.subnet_count) && count < (var.subnet_count * 2)]
  security_groups_ecr         = [module.ecs_cluster.ecs_security_group_id]
  security_groups_cw          = [module.ecs_cluster.ecs_security_group_id, module.ec2_asg.ec2_sg.id]
  security_groups_ssm_ec2_kms = [module.ec2_asg.ec2_sg.id]

  enable_s3_endpoint          = var.enable_s3_endpoint
  enable_ec2messages_endpoint = var.enable_ec2messages_endpoint
  enable_ecr_api_endpoint     = var.enable_ecr_api_endpoint
  enable_ecr_dkr_endpoint     = var.enable_ecr_dkr_endpoint
  enable_ssm_endpoint         = var.enable_ssm_endpoint
  enable_ssmmessages_endpoint = var.enable_ssmmessages_endpoint
  enable_kms_endpoint         = var.enable_kms_endpoint
  enable_logs_endpoint        = var.enable_logs_endpoint
  enable_monitoring_endpoint  = var.enable_monitoring_endpoint
}

# Module for creating autoscaling groups
module "ec2_asg" {
  source = "./modules/ec2_asg"

  vpc_id         = module.vpc_network.vpc_id
  vpc_cidr_block = var.vpc_cidr_block
  aws_region     = var.aws_region
  subnet_ids_asg = [for count in range(length(module.vpc_network.subnets)) : module.vpc_network.subnets[count].id if count > (var.subnet_count - 1) && count < (length(module.vpc_network.subnets) - module.vpc_network.az_list - 1)]
  log_group_name = module.cw_logs.ec2_log_group
}

# Module for creating ECS cluster
module "ecs_cluster" {
  source = "./modules/ecs_cluster"

  vpc_id           = module.vpc_network.vpc_id
  region           = var.aws_region
  target_group_arn = module.alb.target_group_arn
  vpc_cidr_block   = var.vpc_cidr_block
  subnets          = [for count in range(length(module.vpc_network.subnets)) : module.vpc_network.subnets[count].id if count < var.subnet_count && count < module.vpc_network.az_list]
  ecr_image        = var.ecr_image
  log_group_name   = module.cw_logs.ecs_log_group
}

# Module for CloudWatch logs
module "cw_logs" {
  source     = "./modules/cw_logs"
  kms_key_id = aws_kms_key.kms_key.arn
}

# Module for creating Application Load Balancer
module "alb" {
  source = "./modules/alb"

  vpc_id         = module.vpc_network.vpc_id
  vpc_cidr_block = var.vpc_cidr_block
  subnets        = [for count in range(length(module.vpc_network.subnets)) : module.vpc_network.subnets[count].id if count > (length(module.vpc_network.subnets) - module.vpc_network.az_list - 1)]
  sgs            = [module.ecs_cluster.ecs_security_group_id, module.ec2_asg.ec2_sg.id]
  kms_key_id     = aws_kms_key.kms_key.arn
}
