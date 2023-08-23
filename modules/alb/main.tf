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

# Create security group for the ALB
resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # Inbound rules
  ingress {
    description     = "Allow inbound traffic on port 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = var.sgs
  }

  # Outbound rules
  egress {
    description = "Allow outbound traffic within the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }

}

# Create the ALB, target group and HTTP listener
resource "aws_lb" "alb" {
  name                       = "ALB"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = var.subnets
  drop_invalid_header_fields = true

  # Access is logged into S3 bucket
  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    prefix  = "alb-logs"
    enabled = true
  }
}

# Bucket policy and attachment for ALB logs S3 bucket
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AllowALBAccess"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::alb-bucket-for-logs/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::652711504416:root"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.alb_logs.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

# S3 bucket for ALB logs
resource "aws_s3_bucket" "alb_logs" {
  bucket        = "alb-bucket-for-logs"
  force_destroy = true
}

# Enabling versioning for the ALB logs bucket
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.alb_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Blocking public access to the ALB logs bucket
resource "aws_s3_bucket_public_access_block" "access_good_1" {
  bucket = aws_s3_bucket.alb_logs.id

  block_public_acls   = true
  block_public_policy = true

  restrict_public_buckets = true
  ignore_public_acls      = true

}

# Lifecycle configuration for the ALB logs bucket
resource "aws_s3_bucket_lifecycle_configuration" "versioning-bucket-config" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.versioning_example]

  bucket = aws_s3_bucket.alb_logs.id

  rule {
    id = "log"

    filter {
      prefix = "log/"
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    status = "Enabled"
  }
}

# IAM policy for SQS queue for S3 event notifications
data "aws_iam_policy_document" "queue" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:*:*:s3-event-notification-queue-ecs"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.alb_logs.arn]
    }
  }
}

# SQS queue for S3 event notifications
resource "aws_sqs_queue" "queue" {
  name   = "s3-event-notification-queue-ecs"
  policy = data.aws_iam_policy_document.queue.json

  kms_master_key_id                 = var.kms_key_id
  kms_data_key_reuse_period_seconds = 300
}

# Enabling event notifications for the ALB logs bucket, sending to SQS queue
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.alb_logs.id

  queue {
    queue_arn     = aws_sqs_queue.queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}

# Target group
resource "aws_lb_target_group" "main" {
  name        = "targetgroup"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    timeout             = "5"
    unhealthy_threshold = "2"
    path                = "/"
  }
}

# HTTP listener
resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
