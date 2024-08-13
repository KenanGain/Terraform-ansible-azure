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

variable "linux_vm_ids" {
  description = "List of Linux VM IDs"
  type        = list(string)
}

variable "windows_vm_ids" {
  description = "List of Windows VM IDs"
  type        = list(string)
}
