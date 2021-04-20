resource "azurerm_resource_group" "rg" {
  name     = "example-resource-group"
  location = "Australia East"
}

resource "azurerm_storage_account" "sa" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    purpose = "demonstration only"
  }
}