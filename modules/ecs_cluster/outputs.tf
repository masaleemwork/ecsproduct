output "ecs_security_group_id" {
  value       = aws_security_group.ecs_cluster.id
  description = "Returns the security group ID of the ECS cluster"
}
