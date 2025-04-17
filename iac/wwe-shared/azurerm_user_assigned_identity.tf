
# resource "azurerm_user_assigned_identity" "mi_user" {
#   location            = azurerm_resource_group.wwe_shared.location
#   name                = "mi-wwe-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name = azurerm_resource_group.wwe_shared.name
# }