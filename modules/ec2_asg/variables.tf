variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC ID must not be empty"
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

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-07650ecb0de9bd731"
  validation {
    condition     = length(var.ami_id) > 0
    error_message = "AMI ID must not be empty"
  }
}

variable "aws_region" {
  description = "Region in which the VPC will be placed"
  type        = string
  default     = "eu-west-2"
  validation {
    condition     = length(var.aws_region) > 0
    error_message = "Region must not be empty"
  }
}

variable "subnet_ids_asg" {
  description = "Subnet IDs for ASG"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.subnet_ids_asg) > 0
    error_message = "Subnet IDs for ASG must not be empty"
  }
}

variable "log_group_name" {
  description = "CloudWatch Log Group name for EC2"
  type        = string
  validation {
    condition     = length(var.log_group_name) > 0
    error_message = "CloudWatch Log Group name for EC2 must not be empty"
  }
}
