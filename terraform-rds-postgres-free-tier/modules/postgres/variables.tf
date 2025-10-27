variable "project" { type = string }
variable "environment" { type = string }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "instance_class" { type = string }
variable "allocated_storage" { type = number }
variable "engine_version" { type = string }
variable "allowed_cidrs" { type = list(string) }
variable "publicly_accessible" { type = bool }
##variable "db_password" { type = string }
variable "db_secret_version" { 
type = string 
default = "AWSCURRENT" 
  
}
variable "parameters" { 
    type = map(string)  
    default = {}
    description = "values for the DB parameter group"
}