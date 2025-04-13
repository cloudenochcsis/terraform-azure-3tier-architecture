output "app_vm_ids" {
  description = "The IDs of the App Tier VMs"
  value       = azurerm_linux_virtual_machine.app[*].id
}

output "app_vm_private_ips" {
  description = "The private IP addresses of the App Tier VMs"
  value       = azurerm_network_interface.app[*].private_ip_address
}

output "app_nsg_id" {
  description = "The ID of the App Tier Network Security Group"
  value       = azurerm_network_security_group.app.id
}
