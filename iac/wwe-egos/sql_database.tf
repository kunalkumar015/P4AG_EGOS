
module "sql" {
  source = "../modules/sql"

  environment                 = local.environment_sanitized
  organization_suffix         = "wwe"
  region                      = local.region_sanitized
  app_type                    = local.app_type
  sku_name                    = "S0"
  zone_redundant              = false

  # Required network-related variables
  private_endpoint_subnet_id  = azurerm_subnet.shared.id
  subnet_id                   = azurerm_subnet.shared.id
  sql_admin_password          = var.sql_admin_password
  # DNS zone variables
  sql_private_dns_zone_id         = azurerm_private_dns_zone.sql.id        # for Azure SQL
  
 //32 length pw for SQL.
}




# module "sql_database" {
#   source                = "../modules/sql"
#   sku_name              = "S0"
#   zone_redundant        = false
#   environment           = local.environment_sanitized
#   organization_suffix   = "wwe"
#   app_type              = local.app_type
#   region                = local.region_sanitized

  
#   private_endpoint_subnet_id = var.subnet_id
#   private_dns_zone_id        = var.private_dns_zone_id
#   private_dns_zone_id        = var.cosmosdb_private_dns_zone_id
#   subnet_id                    = var.subnet_id
#   cosmosdb_private_dns_zone_id = var.cosmosdb_private_dns_zone_id
# }



# module "cosmos_database" {
#   source              = "../modules/databases"
#   sku_name            = "Standard"
#   zone_redundant      = false
#   environment         = local.environment_sanitized
#   organization_suffix = "wwe"
#   app_type            = local.app_type
#   region              = local.region_sanitized

#   private_endpoint_subnet_id = var.subnet_id
#   private_dns_zone_id        = var.cosmosdb_private_dns_zone_id
# }


