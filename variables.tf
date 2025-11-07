variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "sehs4665-group-project"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.0.11.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.0.12.0/24"
}

variable "data_subnet_1_cidr" {
  description = "CIDR block for data subnet 1"
  type        = string
  default     = "10.0.21.0/24"
}

variable "data_subnet_2_cidr" {
  description = "CIDR block for data subnet 2"
  type        = string
  default     = "10.0.22.0/24"
}

# EC2 Variables
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "ec2_key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
  default     = ""
}

variable "ec2_min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 2
}

variable "ec2_max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 4
}

variable "ec2_desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 2
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0683d724d4cbf410f"
}

# RDS Variables
variable "rds_engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "rds_instance_class" {
  description = "RDS instance class (minimum type)"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "Maximum allocated storage in GB for autoscaling"
  type        = number
  default     = 100
}

variable "rds_db_name" {
  description = "Name of the database"
  type        = string
  default     = "mydb"
}

variable "rds_db_username" {
  description = "Database master username"
  type        = string
  default     = "admin"
}

variable "rds_db_password" {
  description = "Database master password"
  type        = string
}

variable "rds_multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = true
}

variable "rds_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

# ALB Variables
variable "alb_certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listener"
  type        = string
  default     = ""
}

variable "alb_enable_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

# S3 Variables
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "s3_enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "s3_block_public_access" {
  description = "Block public access to the S3 bucket"
  type        = bool
  default     = true
}

# WAF Variables
variable "waf_enable_rate_limit" {
  description = "Enable rate limiting in WAF"
  type        = bool
  default     = true
}

variable "waf_rate_limit" {
  description = "Rate limit (requests per 5 minutes)"
  type        = number
  default     = 2000
}

variable "waf_enable_logging" {
  description = "Enable WAF logging to CloudWatch"
  type        = bool
  default     = true
}

# CloudFront Variables
variable "cloudfront_acm_certificate_arn" {
  description = "ARN of ACM certificate for CloudFront custom domain"
  type        = string
  default     = ""
}

# Tags
variable "tags" {
  description = "A map of tags to assign to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

