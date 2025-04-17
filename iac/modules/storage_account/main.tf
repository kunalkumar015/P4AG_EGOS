locals {
  environment_sanitized       = lower(var.environment)
  org_suffix_sanitized        = lower(var.organization_suffix)
  region_sanitized            = lower(var.region)
  # subscription_name_sanitized = substr(replace(replace(lower(data.azurerm_subscription.current.display_name), " ", ""), "_", ""), 0, 30)
  app_type                    = lower(var.app_type)
  }

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
}

data "azurerm_user_assigned_identity" "mi_user" {
  name                = "mi-wwe-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name = "rg-wwe-shared-prd-${local.region_sanitized}"
}

