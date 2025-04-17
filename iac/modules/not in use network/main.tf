locals {
  environment_sanitized       = lower(var.environment)
  org_suffix_sanitized        = lower(var.organization_suffix)
  region_sanitized            = lower(var.region)
  app_type                    = lower(var.app_type)
  }

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
}

data "azurerm_subnet" "subnet" {
  name                 = "snet-${var.app_name}"
  virtual_network_name = "vnet-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name  = "rg-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
}

