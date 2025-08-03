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

resource "azurerm_subnet" "webapps" {
  name                 = "webapps-subnet"
  virtual_network_name = "vnet-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name  = "rg-wwe-${local.environment_sanitized}"

  address_prefixes = ["172.22.34.128/28"]
}

resource "azurerm_nat_gateway" "nat_gw" {
  name                    = "nat-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name     = "rg-wwe-${local.environment_sanitized}"
  location = var.region
}
