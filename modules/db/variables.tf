variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "private_db_subnet_ids" {
  description = "List of private database subnet IDs"
  type        = list(string)
}

variable "db_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "db_admin" {
  description = "Admin username for the MySQL database"
  type        = string
}

variable "db_password" {
  description = "Password for the MySQL database admin"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
