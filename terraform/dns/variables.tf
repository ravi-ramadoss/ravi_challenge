variable lb_dns_name {
  description = "The DNS name of the load balancer"
  type        = string
}

variable lb_zone_id {
  description = "The zone ID of the load balancer"
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