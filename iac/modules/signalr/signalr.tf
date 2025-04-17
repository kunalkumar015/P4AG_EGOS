resource "azurerm_signalr_service" "signalr" {
  name                         = "sigr-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  location                     = data.azurerm_resource_group.resource_group.location
  resource_group_name          = data.azurerm_resource_group.resource_group.name

  sku {
    name     = var.sku
    capacity = 1
  }

  public_network_access_enabled = var.public_network_access_enabled

  connectivity_logs_enabled = true
  messaging_logs_enabled    = true
  service_mode              = "Default"

}