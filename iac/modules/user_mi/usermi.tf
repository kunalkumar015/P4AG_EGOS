resource "azurerm_user_assigned_identity" "mi_user" {
  location            = data.azurerm_resource_group.resource_group.location
  name                = "mi-wwe-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}