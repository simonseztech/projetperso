provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-projetperso"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage" {
  name                     = "projetpersostorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_storage_container" "blob" {
  name                  = "projetperso"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
