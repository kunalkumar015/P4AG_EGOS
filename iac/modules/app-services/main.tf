locals {
  environment_sanitized       = lower(var.environment)
  org_suffix_sanitized        = lower(var.organization_suffix)
  region_sanitized            = lower(var.region)
  app_type                    = lower(var.app_type)
  }

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-${local.environment_sanitized}"
}

data "azurerm_user_assigned_identity" "mi_user" {
  name                = "mi-wwe-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name = "rg-wwe-${local.environment_sanitized}"
}

data "azurerm_subnet" "consolidated" {
  name                 = "consolidated-subnet"
  virtual_network_name = "vnet-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name  = "rg-wwe-${local.environment_sanitized}"
}

# data "azurerm_log_analytics_workspace" "logs" {
#   name                = "log-wwe-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name = "rg-wwe-shared-prd-${local.region_sanitized}"
# }

data "azurerm_nat_gateway" "nat_gw" {
  name                    = "nat-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name     = "rg-wwe-${local.environment_sanitized}"
}
