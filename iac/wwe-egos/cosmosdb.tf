module "cosmos_database" {
  source              = "../modules/databases"
  sku_name            = "Standard"
  zone_redundant      = false
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_type            = local.app_type
  region              = local.region_sanitized


}
