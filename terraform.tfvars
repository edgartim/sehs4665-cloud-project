# AWS Configuration
aws_region  = "us-east-1"
project_name = "sehs4665-group-project"

# VPC Configuration
vpc_cidr           = "10.0.0.0/16"
public_subnet_1_cidr  = "10.0.1.0/24"
public_subnet_2_cidr  = "10.0.2.0/24"
private_subnet_1_cidr = "10.0.11.0/24"
private_subnet_2_cidr = "10.0.12.0/24"
data_subnet_1_cidr    = "10.0.21.0/24"
data_subnet_2_cidr    = "10.0.22.0/24"

# EC2 Configuration
ec2_instance_type  = "t3.micro"
ec2_key_name       = ""  # Optional: Add your key pair name if you have one
ec2_min_size       = 2
ec2_max_size       = 4
ec2_desired_capacity = 2
ami_id = "ami-0b7d19504b38f7e35"

# RDS Configuration
rds_engine_version         = "8.0"
rds_instance_class         = "db.t3.micro"
rds_allocated_storage      = 20
rds_max_allocated_storage  = 50
rds_db_name                = "mydb"
rds_db_username            = "admin"
rds_db_password            = "ChangeMe123!"
rds_multi_az               = false
rds_backup_retention_period = 7

# S3 Configuration
s3_bucket_name        = "sehs4665-group-project-wp-content"  # Your S3 bucket name
s3_enable_versioning  = true
s3_block_public_access = true

# ALB Configuration
alb_certificate_arn            = ""  # Optional: Add SSL certificate ARN for HTTPS
alb_enable_deletion_protection = false

# WAF Configuration
waf_enable_rate_limit = true
waf_rate_limit        = 2000
waf_enable_logging    = true

# CloudFront Configuration
cloudfront_acm_certificate_arn = ""  # Optional: Add ACM certificate ARN for custom domain

# Tags
tags = {
  Environment = "production"
  ManagedBy   = "Terraform"
  Project     = "sehs4665-group-project"
}

