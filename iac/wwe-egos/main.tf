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
  wwe_subscription_id          = "b09bcb9d-e055-4950-a9dd-2ab6002ef86c"
  app_type                     = lower(var.app_type)
}

terraform {
  backend "azurerm" {
    resource_group_name   = "rg-wwe-dev"
    storage_account_name  = "sttfstatewwedev01"
    container_name        = "egos-eastus2"
    key                  = "wwe-egos-infrastructure/terraform.tfstate"
    # use_msi              = false
    subscription_id       = "b09bcb9d-e055-4950-a9dd-2ab6002ef86c"
    # tenant_id            = "e7520e4d-d5a0-488d-9e9f-949faae7dce8"
    # client_id            = "28bd7a60-c5a9-4581-8ddd-d94f9ba529f4"
    # client_certificate_path = "D:/DevOpsAgents/Agent2/_work/1/self/iac/wwe-egos/yellowwweconomyups.pfx"
    #client_certificate_password = "ups"
    # use_oidc             = false
    
    skip_provider_registration = true
  }
}
