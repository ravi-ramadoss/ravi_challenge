variable "sub_domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
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

variable name_prefix {
  description = "The prefix to use for all resource names"
  type        = string
}