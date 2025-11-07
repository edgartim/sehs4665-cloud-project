# Main Terraform Configuration
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Generate TLS Private Key for EC2
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS Key Pair
resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.project_name}-ec2-key"
  public_key = tls_private_key.ec2_key.public_key_openssh

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ec2-key"
    }
  )
}

# Save private key to local file
resource "local_file" "ec2_private_key" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "${path.module}/${aws_key_pair.ec2_key.key_name}.pem"
  file_permission = "0400"
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name      = var.project_name
  vpc_cidr          = var.vpc_cidr
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]

  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  data_subnet_1_cidr    = var.data_subnet_1_cidr
  data_subnet_2_cidr    = var.data_subnet_2_cidr

  tags = var.tags
}

# S3 Module
module "s3" {
  source = "./modules/s3"
  bucket_name = var.s3_bucket_name
  enable_versioning = var.s3_enable_versioning
  block_public_access = var.s3_block_public_access
  tags = var.tags
}
#
# # WAF Module (CloudFront scope)
# module "waf" {
#   source = "./modules/waf"
#
#   project_name = var.project_name
#   scope        = "CLOUDFRONT"
#
#   enable_rate_limit = var.waf_enable_rate_limit
#   rate_limit        = var.waf_rate_limit
#   enable_logging    = var.waf_enable_logging
#
#   tags = var.tags
# }
#
# # ALB Module
module "alb" {
  source = "./modules/alb"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  certificate_arn            = var.alb_certificate_arn
  enable_deletion_protection = var.alb_enable_deletion_protection
  tags = var.tags
}
#
# # EC2/ASG Module
module "ec2" {
  source = "./modules/ec2"
#
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  alb_security_group_id = module.alb.security_group_id
  target_group_arns   = [module.alb.target_group_arn]
#
  instance_type    = var.ec2_instance_type
  key_name         = aws_key_pair.ec2_key.key_name
  min_size         = var.ec2_min_size
  max_size         = var.ec2_max_size
  desired_capacity = var.ec2_desired_capacity
  s3_bucket_arn    = module.s3.bucket_arn
#
  tags = var.tags
}
#
# # RDS Module
module "rds" {
  source = "./modules/rds"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  data_subnet_ids   = module.vpc.data_subnet_ids
  ec2_security_group_id = module.ec2.security_group_id
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_allocated_storage
  max_allocated_storage  = var.rds_max_allocated_storage
  db_name                = var.rds_db_name
  db_username            = var.rds_db_username
  db_password            = var.rds_db_password
  multi_az               = var.rds_multi_az
  backup_retention_period = var.rds_backup_retention_period
#
  tags = var.tags
}
#
# # CloudFront Module
# module "cloudfront" {
#   source = "./modules/cloudfront"
#
#   project_name      = var.project_name
#   origin_domain_name = module.alb.alb_dns_name
#   origin_id         = "${var.project_name}-alb-origin"
#
#   waf_web_acl_id = module.waf.web_acl_id
#   acm_certificate_arn = var.cloudfront_acm_certificate_arn
#
#   tags = var.tags
# }
#