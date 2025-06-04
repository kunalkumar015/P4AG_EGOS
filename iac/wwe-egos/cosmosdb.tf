module "cosmos_database" {
  source              = "../modules/databases"
  sku_name            = "Standard"
  zone_redundant      = false
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_type            = local.app_type
  region              = local.region_sanitized

  # Enable key features for CosmosDB
  enable_geo_replication = true
  enable_multiple_write_locations = true

  # Optional: Disable public network access
  public_network_access_enabled = false
}
