# Terraform RDS PostgreSQL Free Tier

This project provisions a free-tier eligible AWS RDS PostgreSQL instance using Terraform.

## Usage

1. Update `terraform.tfvars` with your values.
2. Run:
```bash
terraform init
terraform apply
```

## Notes
- Default instance class: `db.t3.micro`
- Storage: 20GB (free tier eligible)
- Change `allowed_cidrs` to restrict DB access.
