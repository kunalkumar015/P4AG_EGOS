# resource "azurerm_private_endpoint" "cosmosdb" {
#   name                = "pep-cosmosdb-${local.environment_sanitized}-${local.region_sanitized}"
#   location            = data.azurerm_resource_group.resource_group.location
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   subnet_id           = var.private_endpoint_subnet_id

#   private_service_connection {
#     name                           = "psc-cosmosdb-${local.environment_sanitized}"
#     private_connection_resource_id = azurerm_cosmosdb_account.cosmosdb.id
#     is_manual_connection           = false
#     subresource_names              = ["Sql"] # Use "Sql" for Cosmos DB SQL API
#   }

#   depends_on = [azurerm_cosmosdb_account.cosmosdb]
# }


# resource "azurerm_cosmosdb_account" "cosmosdb" {
#   name                = "cosmosdb-wwe-${local.environment_sanitized}-${local.region_sanitized}"
#   location            = data.azurerm_resource_group.resource_group.location
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   offer_type          = "Standard"
#   kind                = "GlobalDocumentDB"

#   consistency_policy {
#     consistency_level = "BoundedStaleness"
#     max_interval_in_seconds = 300
#     max_staleness_prefix    = 100000
#   }

#   free_tier_enabled = false
#   public_network_access_enabled = false
#   multiple_write_locations_enabled = false
  
#   geo_location {
#     location          = data.azurerm_resource_group.resource_group.location
#     failover_priority = 0
#   }



# }

# resource "azurerm_cosmosdb_sql_database" "cosmosdb_sql" {
#   name                = "cosmosdb-wwe-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   account_name        = azurerm_cosmosdb_account.cosmosdb.name
# }

# # resource "azurerm_mssql_server" "dbserver" {
# #   name                         = "dbsrv2-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
# #   location                     = data.azurerm_resource_group.resource_group.location
# #   resource_group_name          = data.azurerm_resource_group.resource_group.name
# #   version                      = "12.0"
# #   administrator_login          = "wweadmin"
# #   administrator_login_password = data.azurerm_key_vault_secret.sql_admin_password.value
# #   public_network_access_enabled = false
# #   azuread_administrator {
# #     login_username = "DevOps Team"
# #     object_id = "fb4e0092-7d4f-45b4-8438-db9b45006e80"
# #   }
# # }
# # resource "azurerm_mssql_database" "sqldb" {
# #   name           = "sqldb-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
# #   server_id      = azurerm_mssql_server.dbserver.id
# #   collation      = "SQL_Latin1_General_CP1_CI_AS"
# #   license_type   = "LicenseIncluded"
# #   #max_size_gb    = var.db_max_size_gb
# #   read_scale     = false
# #   sku_name       = "S1"#var.sku_name
# #   zone_redundant = var.zone_redundant
# #   enclave_type   = "VBS"
# #   transparent_data_encryption_enabled = true

# # #   identity {
# # #     type         = "UserAssigned"
# # #     identity_ids = [azurerm_user_assigned_identity.example.id]
# # #   }


# #   # prevent the possibility of accidental data loss
# #   lifecycle {
# #     prevent_destroy = true
# #   }
# # }






# # resource "azurerm_private_endpoint" "sql" {
# #   name                = "pep-sql-${local.environment_sanitized}-${local.region_sanitized}"
# #   location            = data.azurerm_resource_group.resource_group.location
# #   resource_group_name = data.azurerm_resource_group.resource_group.name
# #   subnet_id           = var.private_endpoint_subnet_id

# #   private_service_connection {
# #     name                           = "psc-sql-${local.environment_sanitized}"
# #     private_connection_resource_id = azurerm_mssql_server.dbserver.id
# #     is_manual_connection           = false
# #     subresource_names              = ["sqlServer"]
# #   }

# #   depends_on = [azurerm_mssql_server.dbserver]
# # }





