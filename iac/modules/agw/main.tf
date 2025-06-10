# locals {
#   environment_sanitized = lower(var.environment)
#   region_sanitized      = lower(var.region)
#   app_type              = lower(var.app_type)
# }

# data "azurerm_resource_group" "resource_group" {
#   name = "rg-${local.environment_sanitized}"
# }

# resource "azurerm_public_ip" "public_ip" {
#   name                = "public-ip-${local.app_type}-${local.environment_sanitized}"
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   location            = data.azurerm_resource_group.resource_group.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }
