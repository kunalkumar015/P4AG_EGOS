module "redis_cache" {
  source              = "../modules/redis"
  sku_name            = var.redis_sku
  family              = var.redis_sku_family
  capacity            = 1
  create_redis_link   = var.create_redis_link
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_type            = local.app_type
  region              = local.region_sanitized
}