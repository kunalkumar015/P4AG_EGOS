locals {
  environment_sanitized       = lower(var.environment)
  org_suffix_sanitized        = lower(var.organization_suffix)
  region_sanitized            = lower(var.region)
  # subscription_name_sanitized = substr(replace(replace(lower(data.azurerm_subscription.current.display_name), " ", ""), "_", ""), 0, 30)
  app_type                    = lower(var.app_type)
  }

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-${local.environment_sanitized}"
}

# data "azurerm_redis_cache" "redis_data" {
#   name = "redis-wwe-${local.app_type}-${local.environment_sanitized}-centralus"
#   resource_group_name = "rg-wwe-${local.app_type}-${local.environment_sanitized}-centralus"

# }
data "azurerm_redis_cache" "redis_data" {
  depends_on = [ azurerm_redis_cache.redis ]
  name = "redis-wwe-${local.app_type}-${local.environment_sanitized}-eastus2"
  resource_group_name = "rg-wwe-${local.environment_sanitized}"

}
