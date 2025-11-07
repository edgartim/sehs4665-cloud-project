# Cloud Infrastructure Terraform Configuration

This Terraform configuration deploys a complete AWS cloud environment based on the architecture diagram, including:

- **VPC** with public, private, and data subnets across 2 availability zones
- **EC2 Auto Scaling Group** with minimum 2 small instances
- **RDS MySQL** with Multi-AZ deployment (minimum instance type)
- **Application Load Balancer (ALB)**
- **S3 Bucket** for object storage
- **CloudFront** distribution with WAF
- **CloudWatch** monitoring and alarms

## Architecture

The infrastructure follows a multi-tier architecture:

1. **Edge Layer**: CloudFront + WAF
2. **Load Balancing**: Application Load Balancer in public subnets
3. **Application Layer**: EC2 instances in private subnets with Auto Scaling
4. **Data Layer**: RDS MySQL in data subnets with Multi-AZ
5. **Storage**: S3 bucket for object storage
6. **Monitoring**: CloudWatch for logs and alarms

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- An S3 bucket for Terraform backend (you'll need to provide the bucket name)

## Setup Instructions

1. **Configure S3 Backend**:
   - Edit `backend.tf` and replace `<YOUR_BUCKET_NAME>` with your actual S3 bucket name
   - The bucket should already exist in your AWS account

2. **Configure Variables**:
   - Copy `terraform.tfvars.example` to `terraform.tfvars`
   - Update the values in `terraform.tfvars`, especially:
     - `s3_bucket_name`: Your S3 bucket name for Terraform backend
     - `rds_db_password`: Set a secure password
     - `ec2_key_name`: Your EC2 key pair name (optional)
     - `aws_region`: Your preferred AWS region

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Review the Plan**:
   ```bash
   terraform plan
   ```

5. **Apply the Configuration**:
   ```bash
   terraform apply
   ```

## Module Structure

The configuration uses custom modules organized by service:

- `modules/vpc/` - VPC, subnets, NAT gateways, Internet Gateway
- `modules/ec2/` - EC2 instances, Auto Scaling Group, Launch Template
- `modules/rds/` - RDS MySQL database with Multi-AZ
- `modules/alb/` - Application Load Balancer
- `modules/s3/` - S3 bucket configuration
- `modules/cloudfront/` - CloudFront distribution
- `modules/waf/` - Web Application Firewall
- `modules/cloudwatch/` - CloudWatch logs and alarms

## Key Features

### EC2 Configuration
- Instance type: `t3.small` (configurable)
- Auto Scaling: Minimum 2 instances
- Deployed in private subnets
- IAM role with S3 access permissions

### RDS Configuration
- Engine: MySQL 8.0
- Instance class: `db.t3.micro` (minimum type)
- Multi-AZ: Enabled
- Automated backups: 7 days retention
- Encrypted storage

### Security
- Security groups with least privilege access
- WAF with AWS managed rules
- Rate limiting enabled
- S3 bucket with public access blocked
- RDS in private data subnets

## Outputs

After deployment, Terraform will output:
- ALB DNS name
- CloudFront distribution domain
- RDS endpoint
- S3 bucket name and ARN
- VPC ID
- WAF Web ACL ID

## Important Notes

1. **RDS Password**: Make sure to set a strong password in `terraform.tfvars`
2. **S3 Backend**: The S3 bucket for Terraform backend must exist before running `terraform init`
3. **Costs**: This configuration will create billable AWS resources
4. **Region**: Ensure all resources are created in the same region
5. **Key Pair**: If you specify `ec2_key_name`, the key pair must exist in your AWS account

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

**Warning**: This will delete all resources including the RDS database. Make sure you have backups if needed.

