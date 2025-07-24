locals {
  environment_sanitized       = lower(var.environment)
  org_suffix_sanitized        = lower(var.organization_suffix)
  region_sanitized            = lower(var.region)
  app_type                    = lower(var.app_type)
  }

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-${local.environment_sanitized}"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = "kv2-wwe-${local.environment_sanitized}-${local.region_sanitized}"
  location                    = data.azurerm_resource_group.resource_group.location
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  purge_protection_enabled    = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions         = ["Get", "List"]
    secret_permissions      = ["Get", "List", "Set"]
    certificate_permissions = ["Get", "List"]
  }

  tags = {
    environment = var.environment
  }
}



# data "azurerm_key_vault" "kv" {
#   name                = "kv2-wwe-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name = data.azurerm_resource_group.resource_group.name
# }

# data "azurerm_key_vault_secret" "sql_admin_password" {
#   name         = "sql-password"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# data "azurerm_key_vault_secret" "cosmosdb_admin_password" {
#   name         = "cosmosdb-password"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }