resource "azurerm_postgresql_server" "db" {
  name                             = "${var.humber_id}-psql-server"
  location                         = var.location
  resource_group_name              = var.resource_group_name
  administrator_login              = var.admin_username
  administrator_login_password     = var.db_password
  sku_name                         = "B_Gen5_1"
  storage_mb                       = 5120
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  auto_grow_enabled                = true
  version                          = var.postgresql_version
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled

  tags = var.tags
}

resource "azurerm_postgresql_database" "db" {
  name                = "${var.humber_id}-psql-db"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

