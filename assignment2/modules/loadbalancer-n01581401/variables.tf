# variable "humber_id" {
#   description = "The Humber ID to be used for naming resources"
#   type        = string
# }

# variable "location" {
#   description = "The Azure region to deploy resources"
#   type        = string
# }

# variable "resource_group_name" {
#   description = "The name of the resource group"
#   type        = string
# }

# variable "tags" {
#   description = "A map of tags to be applied to the resources"
#   type        = map(string)
# }
# modules/loadbalancer-n01581401/variables.tf

variable "humber_id" {
  description = "The Humber ID to be used for naming resources"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tags" {
  description = "A map of tags to be applied to the resources"
  type        = map(string)
}

variable "linux_vm_names" {
  description = "A map of Linux VM names and their properties"
  type        = map(any)
}

variable "subnet_id" {
  description = "The ID of the subnet in which to create the VMs"
  type        = string
}

# modules/loadbalancer-n01581401/variables.tf
variable "lb_backend_pool_id" {
  description = "The ID of the load balancer backend address pool"
  type        = string
  default     = ""
}


variable "network_interface_ids" {
  description = "A map of network interface IDs for the VMs"
  type        = map(string)
}

output "load_balancer_fqdn" {
  value = azurerm_public_ip.this.fqdn
}
