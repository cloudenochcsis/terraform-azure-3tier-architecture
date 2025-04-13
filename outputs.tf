output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = module.networking.vnet_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "The IDs of the private app subnets"
  value       = module.networking.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "The IDs of the private database subnets"
  value       = module.networking.private_db_subnet_ids
}

output "bastion_host_ip" {
  description = "The IP address of the Bastion Host"
  value       = module.networking.bastion_host_ip
}

output "application_gateway_public_ip" {
  description = "The public IP address of the Application Gateway"
  value       = module.web.application_gateway_public_ip
}

output "web_vm_private_ips" {
  description = "The private IP addresses of the Web Tier VMs"
  value       = module.web.web_vm_private_ips
}

output "app_vm_private_ips" {
  description = "The private IP addresses of the App Tier VMs"
  value       = module.app.app_vm_private_ips
}

output "mysql_server_fqdn" {
  description = "The FQDN of the MySQL Flexible Server"
  value       = module.db.mysql_server_fqdn
}

output "mysql_private_endpoint_ip" {
  description = "The private IP address of the MySQL Private Endpoint"
  value       = module.db.mysql_private_endpoint_ip
}
