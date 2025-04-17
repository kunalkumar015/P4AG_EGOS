# resource "azurerm_public_ip_prefix" "egos_nat" {
#   name                = "pip-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   location            = azurerm_resource_group.wwe_egos.location
#   resource_group_name = azurerm_resource_group.wwe_egos.name
#   prefix_length       = 29
#   zones               = ["1"]
# }

# resource "azurerm_nat_gateway" "egos_nat" {
#   name                    = "nat-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   location                = azurerm_resource_group.wwe_egos.location
#   resource_group_name     = azurerm_resource_group.wwe_egos.name
#   sku_name                = "Standard"
#   idle_timeout_in_minutes = 10
#   zones                   = ["1"]
# }

# resource "azurerm_nat_gateway_public_ip_prefix_association" "egos_nat" {
#   nat_gateway_id      = azurerm_nat_gateway.egos_nat.id
#   public_ip_prefix_id = azurerm_public_ip_prefix.egos_nat.id
# }
