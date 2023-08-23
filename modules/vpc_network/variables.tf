variable "subnet_count" {
  description = "Number of subnets to use per AZ"
  type        = number
  default     = "3"

  validation {
    condition     = var.subnet_count > 0
    error_message = "Subnet count must greater than 0"
  }
}

variable "vpc_cidr_block" {
  description = "CIDR to be used for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = length(var.vpc_cidr_block) > 0
    error_message = "Subnet count must not be empty"
  }
}

variable "flow_logs_group_arn" {
  type        = string
  description = "ARN of the flow logs group"

  validation {
    condition     = length(var.flow_logs_group_arn) > 0
    error_message = "ARN must be given"
  }
}
