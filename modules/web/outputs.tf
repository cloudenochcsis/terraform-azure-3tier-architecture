output "web_vm_ids" {
  description = "The IDs of the Web Tier VMs"
  value       = azurerm_linux_virtual_machine.web[*].id
}

output "web_vm_private_ips" {
  description = "The private IP addresses of the Web Tier VMs"
  value       = azurerm_network_interface.web[*].private_ip_address
}

output "application_gateway_public_ip" {
  description = "The public IP address of the Application Gateway"
  value       = azurerm_public_ip.agw.ip_address
}

output "web_nsg_id" {
  description = "The ID of the Web Tier Network Security Group"
  value       = azurerm_network_security_group.web.id
}
