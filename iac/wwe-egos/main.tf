locals {
  environment_sanitized        = lower(var.environment)
  org_suffix_sanitized         = lower(var.organization_suffix)
  region_sanitized             = lower(var.location)
  app_type                     = lower(var.app_type)
}

terraform {
  backend "azurerm" {
    resource_group_name   = "rg-wwe-${local.environment_sanitized}"
    container_name        = "egos-${local.region_sanitized}"
    key                  = "wwe-egos-infrastructure/terraform.tfstate"
    skip_provider_registration = true
  }
}
