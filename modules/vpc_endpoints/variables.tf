variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC ID must not be empty"
  }
}

variable "aws_region" {
  description = "Region in which the endpoints will be placed"
  type        = string
  default     = "eu-west-2"
  validation {
    condition     = length(var.aws_region) > 0
    error_message = "Region must not be empty"
  }
}

variable "route_table_ids" {
  description = "Route table IDs for S3 endpoint"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.route_table_ids) > 0
    error_message = "Route Table IDs must not be empty"
  }
}

variable "subnet_ids_ecr_cw" {
  description = "Subnet IDs for ECR and CloudWatch endpoints"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.subnet_ids_ecr_cw) > 0
    error_message = "Subnet IDs for ECR and CloudWatch must not be empty"
  }
}

variable "subnet_ids_ssm_ec2_kms" {
  description = "Subnet IDs for SSM, EC2 and KMS endpoints"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.subnet_ids_ssm_ec2_kms) > 0
    error_message = "Subnet IDs for SSM, EC2 and KMS must not be empty"
  }
}

variable "security_groups_ecr" {
  description = "Security group IDs for ECR endpoints"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.security_groups_ecr) > 0
    error_message = "Security group IDs for ECR endpoints must not be empty"
  }
}

variable "security_groups_cw" {
  description = "Security group IDs for CloudWatch endpoints"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.security_groups_cw) > 0
    error_message = "Security group IDs for CloudWatch endpoints must not be empty"
  }
}

variable "security_groups_ssm_ec2_kms" {
  description = "Security group IDs for SSM, EC2 and KMS endpoints"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.security_groups_ssm_ec2_kms) > 0
    error_message = "Security group IDs for SSM, EC2 and KMS endpoints must not be empty"
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
