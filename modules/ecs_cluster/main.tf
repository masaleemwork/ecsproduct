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

# Create a role and attach a policy to allow ECS to execute tasks
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attach a policy to the role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Create the ECS Fargate Cluster, task definition and service to run the nginx server
resource "aws_ecs_cluster" "fargate_cluster" {
  name = "fargate-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
resource "aws_ecs_task_definition" "nginx_task_definition" {
  family                   = "nginx-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]

  container_definitions = <<DEFINITION
  [
    {
      "name": "nginx-container",
      "image": "${var.ecr_image}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.log_group_name}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  DEFINITION
}

# Creating an ECS service
resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.fargate_cluster.id
  task_definition = aws_ecs_task_definition.nginx_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.ecs_cluster.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "nginx-container"
    container_port   = 80
  }
}


# Create security group for the ECS cluster
resource "aws_security_group" "ecs_cluster" {
  name        = "ecs-cluster-sg"
  description = "Security group for ECS cluster"
  vpc_id      = var.vpc_id

  # Inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
    description = "Allow inbound traffic within the VPC"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
    description = "Allow inbound traffic within the VPC"
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound traffic"
  }
}
