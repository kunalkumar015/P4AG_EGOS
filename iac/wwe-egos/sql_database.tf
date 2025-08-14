
module "sql" {
  source = "../modules/sql"

 database_names = [
    "sqldb-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}",
    "sqldb-wwe-fts-${local.environment_sanitized}-${local.region_sanitized}"
  ]

  environment                 = local.environment_sanitized
  organization_suffix         = "wwe"
  region                      = local.region_sanitized
  app_type                    = local.app_type
  sku_name                    = "S0"
  zone_redundant              = false

  # Required network-related variables
  private_endpoint_subnet_id  = azurerm_subnet.pe_subnet.id // using this (pe_subnet) because shared subnet is already delegated to a specific service (Microsoft.Web/serverFarms)
  subnet_id                   = azurerm_subnet.shared.id
  sql_admin_password          = var.sql_admin_password
  # DNS zone variables
  sql_private_dns_zone_id         = azurerm_private_dns_zone.sql.id        # for Azure SQL
  
 //32 length pw for SQL.
}



# module "sql_fts" {
#   source = "../modules/sql"

#   environment                 = local.environment_sanitized
#   organization_suffix         = "wwe"
#   region                      = local.region_sanitized
#   app_type                    = "fts"
#   sku_name                    = "S0"
#   zone_redundant              = false

#   # Required network-related variables
#   private_endpoint_subnet_id  = azurerm_subnet.pe_subnet.id // using this (pe_subnet) because shared subnet is already delegated to a specific service (Microsoft.Web/serverFarms)
#   subnet_id                   = azurerm_subnet.shared.id
#   sql_admin_password          = var.sql_admin_password
#   # DNS zone variables
#   sql_private_dns_zone_id         = azurerm_private_dns_zone.sql.id        # for Azure SQL
  
#  //32 length pw for SQL.
# }
