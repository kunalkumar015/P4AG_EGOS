locals {
  environment_sanitized = lower(var.environment)
  region_sanitized      = lower(var.region)
  app_type              = lower(var.app_type)
}

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-dev"
}
