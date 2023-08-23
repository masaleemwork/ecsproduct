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

variable "subnets" {
  description = "List of Subnets"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.subnets) > 0
    error_message = "Subnet list must not be empty"
  }
}

variable "sgs" {
  description = "List of security group"
  type        = list(any)
  default     = []
  validation {
    condition     = length(var.sgs) > 0
    error_message = "Security list must not be empty"
  }
}

variable "kms_key_id" {
  description = "KMS customer master key"
  type        = string
}
