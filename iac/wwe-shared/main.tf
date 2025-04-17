terraform {
  backend "azurerm" {
    resource_group_name = "rg-wwe-prod"
    container_name      = "shared-eastus2"
    key                 = "wwe-shared-infrastructure/terraform.tfstate"
  }
}

locals {
  environment_sanitized        = lower(var.environment)
  org_suffix_sanitized         = lower(var.organization_suffix)
  region_sanitized             = lower(var.location)
  wwe_subscription_id          = "6f9f1e7d-bfc5-4c84-a02f-93152a27b55d"
  app_type                     = "shared"
  app_gateway_name             = "agw-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
}
