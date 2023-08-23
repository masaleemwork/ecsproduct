variable "aws_region" {
  description = "Region in which the VPC will be placed"
  type        = string
  default     = "eu-west-2"
  validation {
    condition     = length(var.aws_region) > 0
    error_message = "Region must not be empty"
  }
}

variable "subnet_count" {
  description = "Number of subnets to use per AZ"
  type        = number
  default     = "3"
  validation {
    condition     = var.subnet_count > 0
    error_message = "Must be at least 1 subnet per AZ"
  }
}

variable "vpc_cidr_block" {
  description = "CIDR to be used for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = length(var.vpc_cidr_block) > 0
    error_message = "VPC CIDR block must not be empty"
  }
}

variable "ecr_image" {
  description = "ARN for ECR image"
  type        = string
  default     = "917892242604.dkr.ecr.eu-west-2.amazonaws.com/nginx"
  validation {
    condition     = length(var.ecr_image) > 0
    error_message = "ECR image must not be empty"
  }
}

variable "enable_s3_endpoint" {
  description = "Feature switch for S3 endpoint"
  type        = bool
  default     = true
}

variable "enable_ecr_dkr_endpoint" {
  description = "Feature switch for ECR DKR endpoint"
  type        = bool
  default     = true
}

variable "enable_ecr_api_endpoint" {
  description = "Feature switch for ECR API endpoint"
  type        = bool
  default     = true
}

variable "enable_logs_endpoint" {
  description = "Feature switch for Logs endpoint"
  type        = bool
  default     = true
}

variable "enable_monitoring_endpoint" {
  description = "Feature switch for Monitoring endpoint"
  type        = bool
  default     = true
}

variable "enable_ssm_endpoint" {
  description = "Feature switch for SSM endpoint"
  type        = bool
  default     = true
}

variable "enable_ssmmessages_endpoint" {
  description = "Feature switch for SSM Messages endpoint"
  type        = bool
  default     = true
}

variable "enable_ec2messages_endpoint" {
  description = "Feature switch for EC2 Messages endpoint"
  type        = bool
  default     = true
}

variable "enable_kms_endpoint" {
  description = "Feature switch for KMS endpoint"
  type        = bool
  default     = true
}
