
# resource "azurerm_log_analytics_workspace" "shared_law" {
#   name                = "log-wwe-${local.environment_sanitized}-${local.region_sanitized}"
#   location            = azurerm_resource_group.wwe_shared.location
#   resource_group_name = azurerm_resource_group.wwe_shared.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 365
# }