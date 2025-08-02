locals {
  environment_sanitized = lower(var.environment)
  region_sanitized      = lower(var.region)
  app_type              = lower(var.app_type)
}

data "azurerm_resource_group" "resource_group" {
  name = "rg-wwe-dev"
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-${local.app_type}-${local.environment_sanitized}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_key_vault" "KeyVault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
  tenant_id = var.tenant_id
  location = var.location
  sku_name = "standard"
}

data "azurerm_key_vault_secret" "cert" {
  name         = var.ssl_certificate_name
  key_vault_id = azurerm_key_vault.KeyVault.id
}
