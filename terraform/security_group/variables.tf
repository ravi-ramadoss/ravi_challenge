
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}


variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}