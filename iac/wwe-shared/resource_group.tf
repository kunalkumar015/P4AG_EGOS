# resource "azurerm_resource_group" "wwe_shared" {
#   name     = "rg-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   location = local.region_sanitized

#   lifecycle {
#     ignore_changes = [
#       tags
#     ]
#   }
# }

# resource "azurerm_resource_group" "wwe_devops" {
#   name     = "rg-wwe-devops-${local.environment_sanitized}-${local.region_sanitized}"
#   location = local.region_sanitized

#   lifecycle {
#     ignore_changes = [
#       tags
#     ]
#   }
# }

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-prod"
}