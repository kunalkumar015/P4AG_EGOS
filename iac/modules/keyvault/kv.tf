resource "azurerm_key_vault" "keyvault" {
  name                        = "kv2-wwe-${local.environment_sanitized}-${local.region_sanitized}-v2"
  location                    = data.azurerm_resource_group.resource_group.location
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
  sku_name = "standard"
  lifecycle {
    ignore_changes = [
      # These properties reference internally managed data in Azure
      # Ignore secrets, keys, and certificates entirely
      access_policy,
      network_acls,
      tags
    ]
  }
}
resource "azurerm_key_vault_access_policy" "user_mi" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.user_mi.principal_id

  key_permissions = [
    "Get",
  ]   

  secret_permissions = [
    "Get",
  ]
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = "pep-kv-${local.environment_sanitized}-${local.region_sanitized}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-kv-${local.environment_sanitized}"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["Sql"] # Use "Sql" for Cosmos DB SQL API
  }

  depends_on = [azurerm_key_vault.keyvault]
}
