locals {
  environment_sanitized       = lower(var.environment)
  org_suffix_sanitized        = lower(var.organization_suffix)
  region_sanitized            = lower(var.region)
  app_type                    = lower(var.app_type)
  }

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-${local.environment_sanitized}"
}