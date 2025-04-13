variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "private_app_subnet_ids" {
  description = "List of private app subnet IDs"
  type        = list(string)
}

variable "vm_size" {
  description = "Size of the Virtual Machines"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the Virtual Machines"
  type        = string
}

variable "ssh_key" {
  description = "SSH public key for the Virtual Machines"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
