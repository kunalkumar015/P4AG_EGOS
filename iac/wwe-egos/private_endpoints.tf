# resource "azurerm_private_endpoint" "storage_endpoint" {
#   name                           = "pe-storage"
#   resource_group_name            = "rg-wwe-${local.environment_sanitized}"
#   subnet_id                      = azurerm_subnet.private_endpoints_subnet.id
#   private_service_connection {
#     private_connection_resource_id = azurerm_storage_account.storage.id
#     subresource_names              = ["blob"]
#   }
# }

# resource "azurerm_private_endpoint" "sql_endpoint" {
#   name                           = "pe-sql"
#   location                       = var.location

#   resource_group_name            ="rg-wwe-${local.environment_sanitized}"
#   subnet_id                      = azurerm_subnet.private_endpoints_subnet.id
#   private_service_connection {
#     private_connection_resource_id = azurerm_mssql_server.sql.id
#     subresource_names              = ["sqlServer"]
#   }
# }

# resource "azurerm_private_endpoint" "cosmos_endpoint" {
#   name                           = "pe-cosmos"
#   resource_group_name            = "rg-wwe-${local.environment_sanitized}"
#   location                       = var.location
#   subnet_id                      = azurerm_subnet.private_endpoints_subnet.id
#   private_service_connection {
#     name = "pe-cosmos-service-con"
#     is_manual_connection = false
#     private_connection_resource_id = azurerm_cosmosdb_account.cosmos.id
#     subresource_names              = ["Sql"]
#   }
# }
