# Where to Control Terraform Inputs

You can control Terraform variable inputs in **4 ways** (in order of precedence):

## 1. **terraform.tfvars** (Recommended) ⭐

This is the **main file** where you set your input values. Terraform automatically loads `terraform.tfvars` if it exists.

**Location**: `terraform.tfvars` (in the root directory)

**Example**:
```hcl
aws_region = "us-east-1"
project_name = "sehs4665-group-project"
rds_db_password = "MySecurePassword123!"
s3_bucket_name = "my-bucket-name"
```

**Note**: This file is in `.gitignore` to protect sensitive values like passwords.

---

## 2. **Command Line with `-var` flag**

Override values when running Terraform commands:

```bash
terraform plan -var="rds_db_password=MyPassword123"
terraform apply -var="rds_db_password=MyPassword123" -var="ec2_min_size=3"
```

---

## 3. **Environment Variables**

Set variables using `TF_VAR_` prefix:

```bash
# Windows PowerShell
$env:TF_VAR_rds_db_password="MyPassword123"
$env:TF_VAR_s3_bucket_name="my-bucket"

# Linux/Mac
export TF_VAR_rds_db_password="MyPassword123"
export TF_VAR_s3_bucket_name="my-bucket"
```

---

## 4. **Default Values in variables.tf**

If you don't set a value anywhere else, Terraform uses the default from `variables.tf`:

```hcl
variable "ec2_instance_type" {
  default = "t3.small"  # ← This is used if not overridden
}
```

---

## Priority Order (Highest to Lowest)

1. Command line `-var` flags
2. `terraform.tfvars` file
3. Environment variables (`TF_VAR_*`)
4. Default values in `variables.tf`

---

## Required Variables

These variables **must** be set (no defaults):

- `rds_db_password` - Database password (sensitive)
- `s3_bucket_name` - S3 bucket name

Make sure to set these in `terraform.tfvars`!

---

## Quick Reference

| Variable | Where to Set | Required? |
|----------|-------------|-----------|
| `rds_db_password` | `terraform.tfvars` | ✅ Yes |
| `s3_bucket_name` | `terraform.tfvars` | ✅ Yes |
| `aws_region` | `terraform.tfvars` or default | ❌ No |
| `ec2_instance_type` | `terraform.tfvars` or default | ❌ No |
| `ec2_min_size` | `terraform.tfvars` or default | ❌ No |

---

## Example Workflow

1. **Edit `terraform.tfvars`** with your values
2. **Run** `terraform plan` to see what will be created
3. **Run** `terraform apply` to deploy

Terraform will automatically use values from `terraform.tfvars`!

