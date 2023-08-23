output "load_balancer" {
  value = aws_lb.alb
}

output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}
