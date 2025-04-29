module "redis_cache" {
  source                   = "../modules/keyvault"    
  environment              = local.environment_sanitized
  organization_suffix      = "wwe"
  app_type                 = local.app_type
  region                   = local.region_sanitized
}