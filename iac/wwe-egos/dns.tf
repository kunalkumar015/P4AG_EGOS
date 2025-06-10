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

resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_vnet_link" {
  name                  = "sql-vnet-link"
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = azurerm_virtual_network.wwe_egos.id
}

resource "azurerm_private_dns_zone" "cosmosdb" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "cosmosdb_vnet_link" {
  name                  = "cosmosdb-vnet-link"
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.cosmosdb.name
  virtual_network_id    = azurerm_virtual_network.wwe_egos.id
}
