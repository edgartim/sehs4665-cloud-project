# S3 Backend Configuration
# Replace <YOUR_BUCKET_NAME> with your actual S3 bucket name
terraform {
  backend "s3" {
    bucket = "sehs4665-terraform-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

