
output "lb_security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.lb_sg.id
}

output ec2_security_group_id {
  description = "The ID of the security group"
  value       = aws_security_group.ec2_sg.id
}