variable "project" {
  description = "Project name tag"
  type        = string
  default     = "rds-free-tier"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
  default     = "dev"
}

variable "db_instance_class" {
  description = "RDS instance class (choose free-tier eligible like db.t3.micro/db.t2.micro)"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage in GB (keep <=20 for free tier)"
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "Postgres engine version (major/minor)"
  type        = string
  default     = "16"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "appuser"
}

variable "allowed_cidrs" {
  description = "List of CIDRs allowed to access Postgres (default: limit to local / dev network)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "publicly_accessible" {
  description = "Whether DB instance is publicly accessible (use false for private)"
  type        = bool
  default     = true
}

variable "db_password" {
  description = "Database master password (if not provided, a random one will be generated)"
  type        = string
  sensitive   = true
  default     = ""

}

variable "parameter-file" {
  description = "Path to a custom DB parameter file (JSON format)"
  type        = string
  default     = "db-params.json"

}

variable "db_secret_version" {
  description = "ARN of the AWS Secrets Manager secret to retrieve the DB password from"
  type        = string
  default     = ""

}