resource "azurerm_public_ip_prefix" "ga_nat" {
  name                = "pip-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  prefix_length       = 29
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "ga_nat" {
  name                    = "nat-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  location                = data.azurerm_resource_group.resource_group.location
  resource_group_name     = data.azurerm_resource_group.resource_group.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "ga_nat" {
  nat_gateway_id      = azurerm_nat_gateway.ga_nat.id
  public_ip_prefix_id = azurerm_public_ip_prefix.ga_nat.id
}
