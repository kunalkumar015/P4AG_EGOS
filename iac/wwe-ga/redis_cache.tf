#delete 1124 recreate 0125
# module "redis_cache" {
#   source                   = "../modules/redis"
#   sku_name                 = "Premium"
#   family                   = "P"
#   capacity                 = 1
#   create_redis_link        = var.create_redis_link                 
#   environment              = "prd"
#   organization_suffix      = "wwe"
#   app_type                 = local.app_type
#   region                   = local.region_sanitized
# }