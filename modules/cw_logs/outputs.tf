output "ec2_log_group" {
  description = "Outputs the name for EC2 log group"
  value       = aws_cloudwatch_log_group.ec2-logs.name
}

output "ecs_log_group" {
  description = "Outputs the name for fargate log group"
  value       = aws_cloudwatch_log_group.fargate-logs.name
}

output "flow_log_group" {
  description = "Outputs the name for flow log group"
  value       = aws_cloudwatch_log_group.flow-logs.arn
}
