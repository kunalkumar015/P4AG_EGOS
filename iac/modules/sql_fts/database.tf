# resource "azurerm_mssql_server" "dbserver" {
#   name                         = "dbsrv2-wwe--${local.environment_sanitized}-${local.region_sanitized}"
#   location                     = data.azurerm_resource_group.resource_group.location
#   resource_group_name          = data.azurerm_resource_group.resource_group.name
#   version                      = "12.0"
#   administrator_login          = "wweadmin"
#   administrator_login_password = var.sql_admin_password //data.azurerm_key_vault_secret.sql_admin_password.value
#   public_network_access_enabled = false
#   azuread_administrator { 
#     login_username = "DevOps Team"
#     object_id = "fb4e0092-7d4f-45b4-8438-db9b45006e80"
#   }
# }


# resource "azurerm_mssql_database" "sqldb" {
#   name           = "sqldb-wwe-FTS-${local.environment_sanitized}-${local.region_sanitized}"
#   server_id      = azurerm_mssql_server.dbserver.id
#   collation      = "SQL_Latin1_General_CP1_CI_AS"
#   license_type   = "LicenseIncluded"
#   #max_size_gb    = var.db_max_size_gb
#   read_scale     = false
#   sku_name       = "S1"#var.sku_name
#   zone_redundant = var.zone_redundant
#   enclave_type   = "VBS"
#   transparent_data_encryption_enabled = true

# #   identity {
# #     type         = "UserAssigned"
# #     identity_ids = [azurerm_user_assigned_identity.example.id]
# #   }


#   # prevent the possibility of accidental data loss
#   lifecycle {
#     prevent_destroy = false
#   }
# }

# resource "azurerm_private_endpoint" "sql" {
#   name                = "pep-sql-fts-${local.environment_sanitized}-${local.region_sanitized}"
#   location            = data.azurerm_resource_group.resource_group.location
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   subnet_id           = var.private_endpoint_subnet_id

#   private_service_connection {
#     name                           = "psc-sql-fts${local.environment_sanitized}"
#     private_connection_resource_id = azurerm_mssql_server.dbserver.id
#     is_manual_connection           = false
#     subresource_names              = ["sqlServer"]
#   }

#   depends_on = [azurerm_mssql_server.dbserver]
# }

