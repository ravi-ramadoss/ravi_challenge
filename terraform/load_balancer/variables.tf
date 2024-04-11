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

variable certificate_arn {
  description = "The ARN of the ACM certificate"
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