variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable subnet_1_id {
  description = "The ID of the first subnet"
  type        = string
}

variable subnet_2_id {
  description = "The ID of the second subnet"
  type        = string
}

variable security_group_id {
  description = "The ID of the security group"
  type        = string
}


variable use_blue {
  description = "Use the blue target group"
  type        = bool
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable lb_logs_bucket {
  description = "The name of the S3 bucket to store LB logs"
  type        = string
}

variable name_prefix {
  description = "The prefix to use for all resource names"
  type        = string
}

variable subdomain_certificate_arn {
  description = "The ARN of the wildcard ACM certificate"
  type        = string
}