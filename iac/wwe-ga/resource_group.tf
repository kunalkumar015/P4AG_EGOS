#delete 1124 recreate 0125
# resource "azurerm_resource_group" "wwe_ga" {
#   name     = "rg-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   location = local.region_sanitized

#   lifecycle {
#     ignore_changes = [
#       tags
#     ]
#   }
# }
data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-${local.environment_sanitized}"
}