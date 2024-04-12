output "subdomain_certificate_arn" {
  description = "The ARN of the subdomain ACM certificate"
  value       = aws_acm_certificate.subdomain.arn
}