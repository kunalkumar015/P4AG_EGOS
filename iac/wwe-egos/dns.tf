# resource "azurerm_private_dns_zone" "storage_dns" {
#   name                = "privatelink.blob.core.windows.net"
#   resource_group_name = "rg-wwe-${local.environment_sanitized}"
# }

# resource "azurerm_private_dns_zone" "sql_dns" {
#   name                = "privatelink.database.windows.net"
#   resource_group_name = "rg-wwe-${local.environment_sanitized}"
# }

# resource "azurerm_private_dns_zone" "cosmos_dns" {
#   name                = "privatelink.cosmos.azure.com"
#   resource_group_name = "rg-wwe-${local.environment_sanitized}"
# }
