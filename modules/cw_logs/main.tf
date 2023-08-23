# Terraform provider block stating required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.1"
    }
  }

  required_version = ">= 1.1.7"
}

# CloudWatch log group for ECS
resource "aws_cloudwatch_log_group" "fargate-logs" {
  name              = "fargate-logs"
  retention_in_days = 365
  kms_key_id        = var.kms_key_id
}

# CloudWatch log group for EC2
resource "aws_cloudwatch_log_group" "ec2-logs" {
  name              = "ec2-logs"
  retention_in_days = 365
  kms_key_id        = var.kms_key_id

}

# CloudWatch flow log group for monitoring access into VPC
resource "aws_cloudwatch_log_group" "flow-logs" {
  name              = "flow-logs"
  kms_key_id        = var.kms_key_id
  retention_in_days = 365
}
