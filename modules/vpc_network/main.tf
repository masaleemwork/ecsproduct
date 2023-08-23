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

# Enabling VPC flow logs
resource "aws_flow_log" "vpc-flow-logs" {
  iam_role_arn    = aws_iam_role.flow_role.arn
  log_destination = var.flow_logs_group_arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}

# Policy document to allow vpc-flow-logs to assume role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Creating an IAM role for the flow logs
resource "aws_iam_role" "flow_role" {
  name               = "flow_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Creating a policy document that allows access to CloudWatch logs
data "aws_iam_policy_document" "flow_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

# Associating IAM role to the policy created above
resource "aws_iam_role_policy" "flow_role_policy" {
  name   = "flow_role_policy"
  role   = aws_iam_role.flow_role.id
  policy = data.aws_iam_policy_document.flow_policy.json
}

# Creating the VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "TerraVPC"
  }
}

# Gets a list of available AZs
data "aws_availability_zones" "available" {
}

# Create 1 or more subnets per AZ
resource "aws_subnet" "private_subnet" {
  count             = length(data.aws_availability_zones.available.names) * var.subnet_count
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "${element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))}-Subnet${floor(count.index / var.subnet_count) + 1}"
  }
}

# Create route tables for each subnet
resource "aws_route_table" "private_rt" {
  count  = length(aws_subnet.private_subnet)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Route Table-${element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))}-Subnet${floor(count.index / var.subnet_count) + 1}"
  }
}

# Associate each route table with a subnet
resource "aws_route_table_association" "private_rta" {
  count     = length(aws_subnet.private_subnet)
  subnet_id = element([for subnet in aws_subnet.private_subnet : subnet.id], count.index)
  # subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  # route_table_id = element(aws_route_table.private_rt.*.id, count.index)
  route_table_id = element([for rt in aws_route_table.private_rt : rt.id], count.index)
}
