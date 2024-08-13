# output "lb_name" {
#   value = azurerm_lb.load_balancer.name
# }

# modules/loadbalancer-n01581401/outputs.tf

output "lb_name" {
  description = "The name of the load balancer"
  value       = azurerm_lb.this.name
}

output "lb_public_ip" {
  description = "The public IP address of the load balancer"
  value       = azurerm_public_ip.this.ip_address
}

output "lb_backend_address_pool_id" {
  description = "The ID of the load balancer backend address pool"
  value       = azurerm_lb_backend_address_pool.this.id
}
output "lb_fqdn" {
  description = "The Fully Qualified Domain Name (FQDN) of the load balancer"
  value       = azurerm_public_ip.this.fqdn
}
