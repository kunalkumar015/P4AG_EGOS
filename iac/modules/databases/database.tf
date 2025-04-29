resource "azurerm_mssql_server" "dbserver" {
  name                         = "dbsrv2-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  location                     = data.azurerm_resource_group.resource_group.location
  resource_group_name          = data.azurerm_resource_group.resource_group.name
  version                      = "12.0"
  administrator_login          = "wweadmin"
  administrator_login_password = "null"
  azuread_administrator {
    login_username = "DevOps Team"
    object_id = "fb4e0092-7d4f-45b4-8438-db9b45006e80"
  }
}
resource "azurerm_mssql_database" "sqldb" {
  name           = "sqldb-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  server_id      = azurerm_mssql_server.dbserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  #max_size_gb    = var.db_max_size_gb
  read_scale     = false
  sku_name       = var.sku_name
  zone_redundant = var.zone_redundant
  enclave_type   = "VBS"
  transparent_data_encryption_enabled = true

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.example.id]
#   }


  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
