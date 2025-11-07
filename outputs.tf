# Key Pair Outputs
output "ec2_key_pair_name" {
  description = "Name of the EC2 key pair"
  value       = aws_key_pair.ec2_key.key_name
}

output "ec2_private_key" {
  description = "Private key for EC2 instances (PEM format)"
  value       = tls_private_key.ec2_key.private_key_pem
  sensitive   = true
}

output "ec2_private_key_file" {
  description = "Path to the saved private key file"
  value       = local_file.ec2_private_key.filename
}

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

# S3 Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

