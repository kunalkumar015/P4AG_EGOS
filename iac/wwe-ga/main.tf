terraform {
  backend "azurerm" {
    resource_group_name = "rg-wwe-prod"
    container_name      = "ga"
    key                 = "wwe-ga-infrastructure/terraform.tfstate"
  }
}

locals {
  environment_sanitized        = lower(var.environment)
  org_suffix_sanitized         = lower(var.organization_suffix)
  region_sanitized             = lower(var.location)
  wwe_subscription_id          = "6f9f1e7d-bfc5-4c84-a02f-93152a27b55d"
  app_type                     = lower(var.app_type)

}
