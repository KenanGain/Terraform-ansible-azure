terraform {
  backend "azurerm" {
    storage_account_name = "tfstaten01581401sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}