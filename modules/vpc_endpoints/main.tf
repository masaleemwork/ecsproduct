# Terraform provider block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.1"
    }
  }

  required_version = ">= 1.1.7"
}

# Create various VPC endpoints for ECR, S3, CloudWatch, KMS

# S3 endpoint
resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  # Put a route in every route table
  route_table_ids = var.route_table_ids

  tags = {
    Name = "S3-Endpoint"
  }
}

# ECR-DKR endpoint
resource "aws_vpc_endpoint" "ecr-dkr-endpoint" {
  count = var.enable_ecr_dkr_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = var.security_groups_ecr
  # Associate endpoint with first 3 subnets (one in each AZ)
  subnet_ids = var.subnet_ids_ecr_cw

  tags = {
    Name = "ECR-DKR-Endpoint"
  }
}

# ECR-API endpoint
resource "aws_vpc_endpoint" "ecr-api-endpoint" {
  count = var.enable_ecr_api_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = var.security_groups_ecr
  subnet_ids          = var.subnet_ids_ecr_cw

  tags = {
    Name = "ECR-API-Endpoint"
  }
}

# Cloudwatch logs endpoint
resource "aws_vpc_endpoint" "logs-endpoint" {
  count = var.enable_logs_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = var.security_groups_cw
  subnet_ids          = var.subnet_ids_ecr_cw

  tags = {
    Name = "Logs-Endpoint"
  }
}

# Cloudwatch monitoring endpoint
resource "aws_vpc_endpoint" "monitoring-endpoint" {
  count = var.enable_monitoring_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.monitoring"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = var.security_groups_cw
  subnet_ids          = var.subnet_ids_ecr_cw

  tags = {
    Name = "Monitoring-Endpoint"
  }
}

# SSM endpoint
resource "aws_vpc_endpoint" "ssm-endpoint" {
  count = var.enable_ssm_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = var.security_groups_ssm_ec2_kms
  # Associate endpoint with the middle 3 subnets (one in each AZ)
  subnet_ids = var.subnet_ids_ssm_ec2_kms

  tags = {
    Name = "SSM-Endpoint"
  }
}

# SSM-messages endpoint
resource "aws_vpc_endpoint" "ssmmessages-endpoint" {
  count = var.enable_ssmmessages_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = var.security_groups_ssm_ec2_kms
  subnet_ids          = var.subnet_ids_ssm_ec2_kms

  tags = {
    Name = "SSM-Messages-Endpoint"
  }
}

# EC2-messages endpoint
resource "aws_vpc_endpoint" "ec2messages-endpoint" {
  count = var.enable_ec2messages_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = var.security_groups_ssm_ec2_kms
  subnet_ids          = var.subnet_ids_ssm_ec2_kms

  tags = {
    Name = "EC2-Messages-Endpoint"
  }
}

# KMS endpoint
resource "aws_vpc_endpoint" "kms-endpoint" {
  count = var.enable_kms_endpoint ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = var.security_groups_ssm_ec2_kms
  subnet_ids          = var.subnet_ids_ssm_ec2_kms

  tags = {
    Name = "KMS-Endpoint"
  }
}
