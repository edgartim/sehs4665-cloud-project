variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "origin_domain_name" {
  description = "Domain name of the origin (ALB DNS name)"
  type        = string
}

variable "origin_id" {
  description = "Unique identifier for the origin"
  type        = string
  default     = "alb-origin"
}

variable "enable_ipv6" {
  description = "Enable IPv6"
  type        = bool
  default     = true
}

variable "default_root_object" {
  description = "Default root object"
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "Price class for CloudFront"
  type        = string
  default     = "PriceClass_100" # Use only North America and Europe
}

variable "geo_restriction_type" {
  description = "Type of geo restriction"
  type        = string
  default     = "none" # none, whitelist, blacklist
}

variable "geo_restriction_locations" {
  description = "List of country codes for geo restriction"
  type        = list(string)
  default     = []
}

variable "use_default_certificate" {
  description = "Use CloudFront default certificate"
  type        = bool
  default     = true
}

variable "acm_certificate_arn" {
  description = "ARN of ACM certificate for custom domain"
  type        = string
  default     = ""
}

variable "waf_web_acl_id" {
  description = "WAF Web ACL ID to associate with CloudFront"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

