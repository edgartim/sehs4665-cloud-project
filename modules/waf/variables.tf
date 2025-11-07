variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "scope" {
  description = "Scope of the WAF (CLOUDFRONT or REGIONAL)"
  type        = string
  default     = "CLOUDFRONT"
}

variable "enable_rate_limit" {
  description = "Enable rate limiting"
  type        = bool
  default     = true
}

variable "rate_limit" {
  description = "Rate limit (requests per 5 minutes)"
  type        = number
  default     = 2000
}

variable "enable_logging" {
  description = "Enable WAF logging to CloudWatch"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Number of days to retain WAF logs"
  type        = number
  default     = 7
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

