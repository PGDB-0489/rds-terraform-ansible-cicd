terraform {
  backend "s3" {
    bucket         = "argha-cicd-tf-state-bucket"
    key            = "terraform-rds-postgres-free-tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}