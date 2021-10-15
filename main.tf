provider "azurerm" {
  version = "~> 2.47"
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_redis_cache" "example" {
  name                = "example-cache-chrrice1234"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "examplechrrice123"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id = resource.azurerm_redis_cache.example.id
  storage_account_id = resource.azurerm_storage_account.example.id

  log {
    category = "ConnectedClientList"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}
