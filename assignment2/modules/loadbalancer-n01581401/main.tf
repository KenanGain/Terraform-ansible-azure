# resource "azurerm_lb" "load_balancer" {
#   name                = "${var.humber_id}-lb"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   sku = "Basic"

#   tags = var.tags
# }
# modules/loadbalancer-n01581401/main.tf
# Public IP for the Load Balancer
resource "azurerm_public_ip" "this" {
  name                = "${var.humber_id}-lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"  # Changed to Standard to match LB SKU
}

# Load Balancer
resource "azurerm_lb" "this" {
  name                = "${var.humber_id}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"  # Changed to Standard for better features
  
  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = var.tags
}

# Backend Address Pool
resource "azurerm_lb_backend_address_pool" "this" {
  name            = "backend"
  loadbalancer_id = azurerm_lb.this.id
}

# Health Probe
resource "azurerm_lb_probe" "http" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.this.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

# Load Balancing Rule
resource "azurerm_lb_rule" "http" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.http.id
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_association" {
  for_each                     = var.linux_vm_names
  network_interface_id         = var.network_interface_ids[each.key]
  backend_address_pool_id      = azurerm_lb_backend_address_pool.this.id
  ip_configuration_name        = "internal"  # Ensure this matches the name used in your NIC resource
}
