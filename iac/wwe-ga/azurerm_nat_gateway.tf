#delete 1124 recreate 0125
# resource "azurerm_public_ip_prefix" "natgw" {
#   name                = "pip-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   location            = azurerm_resource_group.wwe_ga.location
#   resource_group_name = azurerm_resource_group.wwe_ga.name
#   prefix_length       = 29
#   zones               = ["1"]
# }

# resource "azurerm_nat_gateway" "natgw" {
#   name                    = "nat-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   location                = azurerm_resource_group.wwe_ga.location
#   resource_group_name     = azurerm_resource_group.wwe_ga.name
#   sku_name                = "Standard"
#   idle_timeout_in_minutes = 10
#   zones                   = ["1"]
# }

# resource "azurerm_nat_gateway_public_ip_prefix_association" "natgw" {
#   nat_gateway_id      = azurerm_nat_gateway.natgw.id
#   public_ip_prefix_id = azurerm_public_ip_prefix.natgw.id
# }
