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

# Security Group for the EC2 instance
resource "aws_security_group" "ec2" {
  name        = "ec2-sg"
  description = "Security group for EC2"
  vpc_id      = var.vpc_id

  # Inbound rules
  ingress {
    description = "Allow inbound traffic on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block] # Allow inbound traffic within the VPC
  }

  ingress {
    description = "Allow inbound traffic on port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block] # Allow inbound traffic within the VPC
  }

  # Outbound rules
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic
  }
}

# Create a role and attach a policy to allow EC2 to access Session Manager and CloudWatch
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attaching AWS-managed policies to the role
resource "aws_iam_role_policy_attachment" "ec2_managed_policy_cw_agent" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "ec2_managed_policy_ssm_instance" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_managed_policy_ssm_directory" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}

# Creating a custom policy for the role (to allow SSM access)
resource "aws_iam_role_policy" "kms_ec2_policy" {
  # checkov:skip=CKV_AWS_355:Resource is not known beforehand
  # checkov:skip=CKV_AWS_290:Resource is not known beforehand
  name = "KMS_EC2_Policy"
  role = aws_iam_role.ec2_role.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "kms:Decrypt",
                "kms:GenerateDataKey"
            ],
            "Resource": "*",
            "Effect": "Allow",
            "Sid": "S3CentralLogsEncryption"
        },
        {
            "Action": "kms:Decrypt",
            "Resource": "*",
            "Effect": "Allow",
            "Sid": "sessionKey"
        }
    ]
}
POLICY
}

# Creating instance profile for the EC2 instance
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}

# Lauch template for EC2 instances, used with autoscaling group
resource "aws_launch_template" "ec2_launch_template" {
  name = "ec2-launch-template-terra"

  image_id = var.ami_id

  instance_type = "t2.micro"

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_profile.arn
  }

  vpc_security_group_ids = [aws_security_group.ec2.id]

  # Retrieve, install, configure and start the CloudWatch agent on the EC2 instance
  user_data = base64encode(<<-EOF
              #!/bin/bash
              file_path="/tmp/amazon-cloudwatch-agent.json"

              content='{
                  "logs": {
                    "logs_collected": {
                      "files": {
                        "collect_list": [
                          {
                            "file_path": "/var/log/cloud-init.log",
                            "log_group_name": "${var.log_group_name}",
                            "log_stream_name": "{instance_id}_logs"
                          }
                        ]
                      }
                    }
                  }
                }'
                echo "$content" | sudo tee "$file_path" > /dev/null
                sudo wget https://s3.${var.aws_region}.amazonaws.com/amazoncloudwatch-agent-${var.aws_region}/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
                sudo yum install ./amazon-cloudwatch-agent.rpm -y
                sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -s -c "file://$file_path"
                sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
                sudo systemctl start amazon-cloudwatch-agent
                EOF
  )
}

# Create EC2 autoscaling group, using launch template
resource "aws_autoscaling_group" "ec2_autoscaling_group" {
  name = "ec2-autoscaling-group-terra"

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest" # Use the latest version of the launch template
  }
  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  vpc_zone_identifier = var.subnet_ids_asg

  # Tags for autoscaling group
  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
}
