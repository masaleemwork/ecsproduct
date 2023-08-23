variable "vpc_id" {
  description = "VPC ID"
  type        = string
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC ID must not be empty"
  }
}

variable "region" {
  description = "VPC region"
  type        = string
  default     = "eu-west-2"
  validation {
    condition     = length(var.region) > 0
    error_message = "Region must not be empty"
  }
}

variable "target_group_arn" {
  description = "Target group ARN for ALB"
  type        = string
  validation {
    condition     = length(var.target_group_arn) > 0
    error_message = "Target group ARN for ALB must not be empty"
  }
}

variable "vpc_cidr_block" {
  description = "CIDR block to be used for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = length(var.vpc_cidr_block) > 0
    error_message = "VPC CIDR block must not be empty"
  }
}

variable "subnets" {
  description = "Subnet IDs for ECS cluster"
  type        = list(any)
  validation {
    condition     = length(var.subnets) > 0
    error_message = "Subnet IDs for ECS not be empty"
  }
}

variable "ecr_image" {
  description = "ARN for ECR image"
  type        = string
  validation {
    condition     = length(var.ecr_image) > 0
    error_message = "ECR image must not be empty"
  }
}

variable "log_group_name" {
  description = "CloudWatch Log Group name for ECS"
  type        = string
  validation {
    condition     = length(var.log_group_name) > 0
    error_message = "CloudWatch Log Group name for ECS must not be empty"
  }
}
