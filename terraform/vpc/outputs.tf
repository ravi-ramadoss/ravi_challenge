output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.comcast_take_home.id
}

output "subnet_1_id" {
  description = "The ID of the first subnet"
  value       = aws_subnet.subnet_1.id
}

output "subnet_2_id" {
  description = "The ID of the second subnet"
  value       = aws_subnet.subnet_2.id
}