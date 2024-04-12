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

variable "lb_logs_bucket_name" {
  description = "The name of the S3 bucket to store LB logs"
  type        = string
  default     = "raviramadoss-elb-logs"
}

variable account_id {
  description = "The account ID"
  type        = string
  default   = "308655275891"
}

variable name_prefix {
  description = "The prefix to use for all resource names"
  type        = string
  default     = "cc-"
}