# terraform {
#   backend "azurerm" {
#     resource_group_name = "rg-wwe-dev"
#     container_name      = "egos"
#     key                 = "wwe-egos-infrastructure/terraform.tfstate"
#   }
# }

locals {
  environment_sanitized        = lower(var.environment)
  org_suffix_sanitized         = lower(var.organization_suffix)
  region_sanitized             = lower(var.location)
  # wwe_subscription_id          = "b09bcb9d-e055-4950-a9dd-2ab6002ef86c"
  app_type                     = lower(var.app_type)
}

terraform {
  backend "azurerm" {
    resource_group_name   = "rg-wwe-${local.environment_sanitized}"
    # storage_account_name  = "sttfstatewwedev01"
    container_name        = "egos-${local.region_sanitized}"
    key                  = "wwe-egos-infrastructure/terraform.tfstate"
    # subscription_id       = "b09bcb9d-e055-4950-a9dd-2ab6002ef86c"
    skip_provider_registration = true
  }
}
