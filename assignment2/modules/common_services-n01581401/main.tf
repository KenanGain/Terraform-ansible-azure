resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.humber_id}storageacct"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = "${var.humber_id}RecoveryVault"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard" # Provide the appropriate SKU value

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${var.humber_id}LogAnalytics"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018" # Example SKU value, adjust as needed

  tags = var.tags
}




