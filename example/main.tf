resource "azurerm_resource_group" "rg" {
  name     = "example-resource-group"
  location = "Australia East"
}

resource "azurerm_storage_account" "sa1" {
  name                      = "aqitstorage001"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  allow_blob_public_access = false

  tags = {
    purpose = "demonstration only"
  }
}

resource "azurerm_storage_account" "sa2" {
  name                     = "aqitstorage002"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = false
  min_tls_version           = "TLS1_0"
  allow_blob_public_access = true

  tags = {
    purpose = "demonstration only"
  }
}

resource "azurerm_storage_account" "sa3" {
  name                     = "aqitstorage003"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = false
  min_tls_version           = "TLS1_0"
  allow_blob_public_access = true

  tags = {
    purpose = "demonstration only"
  }
}