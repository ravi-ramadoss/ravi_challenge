variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable name_prefix {
  description = "The prefix to use for all resource names"
  type        = string
}