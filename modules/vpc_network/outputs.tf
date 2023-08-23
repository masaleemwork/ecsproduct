output "subnets" {
  description = "Outputs the private subnets"
  value       = aws_subnet.private_subnet
}

output "subnet_rts" {
  description = "Outputs the name for the private route table"
  value       = aws_route_table.private_rt
}

output "vpc_id" {
  description = "Outputs the VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_list" {
  description = "Outputs the subnet list"
  value       = [for subnet in aws_subnet.private_subnet : subnet.tags.Name]
}

output "az_list" {
  description = "Outputs the AZ list"
  value       = length(data.aws_availability_zones.available.names)
}
