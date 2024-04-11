variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

variable "zone_id" {
  description = "The ID of the Route53 zone"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}