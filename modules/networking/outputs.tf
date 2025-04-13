output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = azurerm_subnet.public[*].id
}

output "private_app_subnet_ids" {
  description = "The IDs of the private app subnets"
  value       = azurerm_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  description = "The IDs of the private database subnets"
  value       = azurerm_subnet.private_db[*].id
}

output "bastion_host_ip" {
  description = "The IP address of the Bastion Host"
  value       = azurerm_public_ip.bastion.ip_address
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = azurerm_nat_gateway.main.id
}
