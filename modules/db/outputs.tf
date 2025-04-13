output "mysql_server_id" {
  description = "The ID of the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.main.id
}

output "mysql_server_fqdn" {
  description = "The FQDN of the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.main.fqdn
}

output "mysql_private_endpoint_ip" {
  description = "The private IP address of the MySQL Private Endpoint"
  value       = azurerm_private_endpoint.mysql.private_service_connection[0].private_ip_address
}

output "db_nsg_id" {
  description = "The ID of the Database Tier Network Security Group"
  value       = azurerm_network_security_group.db.id
}
