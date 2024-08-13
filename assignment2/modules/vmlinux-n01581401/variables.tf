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

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "storage_account_uri" {
  description = "The URI of the storage account"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VMs"
  type        = string
}

variable "public_key_path" {
  description = "The path to the public key for SSH access"
  type        = string
  default = "/Users/n01649908/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "The path to the private key for SSH access"
  type        = string
  default = "/Users/n01649908/.ssh/id_rsa"
}

variable "tags" {
  description = "A map of tags to be applied to the resources"
  type        = map(string)
}

variable "linux_vm_names" {
  description = "A map of names for the Linux VMs"
  type        = map(string)
}

variable "linux_vm_size" {
  description = "The size of the Linux VMs"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostics"
  type        = string
}

output "network_interface_ids" {
  value = { for vm_name, nic in azurerm_network_interface.nic : vm_name => nic.id }
}
