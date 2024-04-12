variable "blue_target_group_arn" {
  description = "The ARN of the blue target group"
  type        = string
}

variable "green_target_group_arn" {
  description = "The ARN of the green target group"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable ami_id {
  description = "The ID of the AMI"
  type        = string
}

variable key_name {
  description = "The name of the key pair"
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

variable ec2_security_group_id {
  description = "The ID of the security group"
  type        = string
}

variable lb_security_group_id {
  description = "The ID of the security group"
  type        = string
}