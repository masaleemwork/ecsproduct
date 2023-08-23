output "alb_dns_name" {
  description = "Output for application load balancer DNS name"
  value       = module.alb.load_balancer.dns_name
}
