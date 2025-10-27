data "aws_vpc" "default" {
  default = true
}

# fetch all subnets in default VPC
data "aws_subnets" "default_vpc" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.environment}-db-subnet-group"
  subnet_ids = data.aws_subnets.default_vpc.ids

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_security_group" "db" {
  name        = "${var.project}-${var.environment}-db-sg"
  description = "Allow Postgres inbound"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
    description = "Allow Postgres"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = "${var.project}-${var.environment}-db"
  engine                  = "postgres"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = random_password.db_password.result
  allocated_storage       = var.allocated_storage
  storage_type            = "gp3"
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  publicly_accessible     = var.publicly_accessible
  multi_az                = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7
  auto_minor_version_upgrade = true

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret" "mypgsecret" {
  name = "${var.project}-${var.environment}-db-credentials"
  description = "RDS Postgres credentials for ${var.project}-${var.environment}"
  
  lifecycle {
    prevent_destroy = false
  }
   
  tags = {
    Project     = var.project
    Environment = var.environment
  }
  
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id     = aws_secretsmanager_secret.mypgsecret.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    host     = aws_db_instance.postgres.address
    port     = aws_db_instance.postgres.port
    dbname   = var.db_name
  })
  
}

resource "aws_db_parameter_group" "custom" {

  name        = "${var.project}-${var.environment}-db-parameter-group"
  #family      = "postgres${replace(var.engine_version, ".", "")}"
  family      =  "postgres${split(".", var.engine_version)[0]}"
  description = "Custom parameter group for ${var.project}-${var.environment} Postgres"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.key
      value = parameter.value
      ##apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }
  tags = {
    Project     = var.project
    Environment = var.environment
  }

}