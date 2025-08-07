locals {
  environment_sanitized       = lower(var.environment)
  org_suffix_sanitized        = lower(var.organization_suffix)
  region_sanitized            = lower(var.region)
  app_type                    = lower(var.app_type)
  }


resource "azurerm_user_assigned_identity" "mi_user" {
  name                = "mi-wwe-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name = "rg-wwe-${local.environment_sanitized}"
  location = var.region
}

# data "azurerm_subnet" "shared" {
#   name                 = "shared-subnet"
#   virtual_network_name = "vnet-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
# }

# resource "azurerm_nat_gateway" "nat_gw" {
#   name                    = "nat-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name     = "rg-wwe-${local.environment_sanitized}"
#   location                = "eastus2"
# }
