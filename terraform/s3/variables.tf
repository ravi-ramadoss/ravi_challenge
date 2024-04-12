variable lb_logs_bucket_name {
  description = "The name of the S3 bucket to store ELB logs"
  type        = string
}
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable lb_arn {
  description = "The ARN of the ELB"
  type        = string
}

variable account_id {
  description = "The account ID"
  type        = string
}


variable name_prefix {
  description = "The prefix to use for all resource names"
  type        = string
}