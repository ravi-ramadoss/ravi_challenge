variable "use_blue" {
  description = "A boolean that determines whether to use the blue target group"
  type        = bool
  default     = true
}
variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
  default    = "raviramadoss.me"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {
    project = "comcast"
  }
}

variable ami_id {
  description = "The ID of the AMI"
  type        = string
  default     = "ami-0395649fbe870727e"
}

variable key_name {
  description = "The name of the key pair"
  type        = string
  default     = "ravi-ramadoss-oregon"
}