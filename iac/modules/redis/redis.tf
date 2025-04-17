resource "azurerm_redis_cache" "redis" {
  name                 = "redis-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  location             = data.azurerm_resource_group.resource_group.location
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  capacity             = var.capacity
  family               = var.family
  sku_name             = var.sku_name
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
  zones                = [1]

  redis_configuration {
  }
}

# resource "azurerm_redis_linked_server" "redis-link" {
#   count                       = var.create_redis_link
#   target_redis_cache_name     = azurerm_redis_cache.redis.name
#   resource_group_name         = azurerm_redis_cache.redis.resource_group_name
#   linked_redis_cache_id       = data.azurerm_redis_cache.redis_data.id
#   linked_redis_cache_location = data.azurerm_redis_cache.redis_data.location
#   server_role                 = "Secondary"
# }

resource "azurerm_redis_linked_server" "redis-link" {
  count                       = var.create_redis_link
  target_redis_cache_name     = azurerm_redis_cache.redis.name
  resource_group_name         = azurerm_redis_cache.redis.resource_group_name
  linked_redis_cache_id       = data.azurerm_redis_cache.redis_data.id
  linked_redis_cache_location = data.azurerm_redis_cache.redis_data.location
  server_role                 = "Primary"
  depends_on = [ 
    azurerm_redis_cache.redis 
  ]
}