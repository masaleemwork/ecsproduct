output "ec2_sg" {
  value       = aws_security_group.ec2
  description = "Returns the security group of the EC2 instance"
}
