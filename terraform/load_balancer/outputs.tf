
output "blue_target_group_arn" {
  description = "The ARN of the blue target group"
  value       = aws_lb_target_group.blue.arn
}

output "green_target_group_arn" {
  description = "The ARN of the green target group"
  value       = aws_lb_target_group.green.arn
}

output "lb_dns_name" {
  value = aws_lb.web_lb.dns_name
}

output "lb_zone_id" {
  value = aws_lb.web_lb.zone_id
}

output "lb_arn" {
  value = aws_lb.web_lb.arn
}