locals {
  environment_sanitized       = lower(var.environment)
  org_suffix_sanitized        = lower(var.organization_suffix)
  region_sanitized            = lower(var.region)
  app_type                    = lower(var.app_type)
  }

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-${local.environment_sanitized}"
}
data "azurerm_key_vault" "kv" {
  name                = "your-keyvault-name"
  resource_group_name = "your-keyvault-rg"
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-password"
  key_vault_id = data.azurerm_key_vault.example.id
}