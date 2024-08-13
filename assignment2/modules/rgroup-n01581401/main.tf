resource "azurerm_resource_group" "rg" {
  name     = "${var.humber_id}-rg"
  location = var.location
  tags     = var.tags
}