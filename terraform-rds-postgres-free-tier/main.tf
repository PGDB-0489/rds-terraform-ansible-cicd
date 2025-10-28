module "postgres" {
  source = "./modules/postgres"

  project             = var.project
  environment         = var.environment
  db_name             = var.db_name
  db_username         = var.db_username
  instance_class      = var.db_instance_class
  allocated_storage   = var.allocated_storage
  engine_version      = var.engine_version
  allowed_cidrs       = var.allowed_cidrs
  publicly_accessible = var.publicly_accessible
  parameters          = local.db_params
  db_secret_version   = var.db_secret_version
}

locals {
  db_params = jsondecode(file(var.parameter-file))
}
