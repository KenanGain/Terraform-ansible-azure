output "windows_vm_hostnames" {
  value = azurerm_windows_virtual_machine.virtual_machine[*].name
}

output "windows_vm_fqdns" {
  value = azurerm_public_ip.public_ip[*].fqdn
}

output "windows_vm_private_ips" {
  value = azurerm_network_interface.nic[*].private_ip_address
}

output "windows_vm_public_ips" {
  value = azurerm_public_ip.public_ip[*].ip_address
}


output "windows_vm_ids" {
  value = [for vm in azurerm_windows_virtual_machine.virtual_machine : vm.id]
}
