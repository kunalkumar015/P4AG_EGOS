module "cosmosdb" {
  source              = "../modules/cosmosdb"
  sku_name            = "Standard"
  zone_redundant      = false
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_type            = local.app_type
  region              = local.region_sanitized

  private_endpoint_subnet_id = var.subnet_id
  subnet_id                   = azurerm_subnet.shared.id
  cosmosdb_private_dns_zone_id = azurerm_private_dns_zone.cosmosdb.id  # for Cosmos DB
  
}

