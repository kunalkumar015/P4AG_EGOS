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
  name                = "kv2-wwe-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "test"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "cosmosdb_admin_password" {
  name         = "cosmosdb-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}