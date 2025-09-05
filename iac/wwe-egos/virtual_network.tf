resource "azurerm_virtual_network" "wwe_egos" {
  name                = "vnet-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name = "rg-wwe-${local.environment_sanitized}"
  location            = data.azurerm_resource_group.resource_group.location

  address_space = var.vnet_address_space
  lifecycle {
    ignore_changes = [
      ddos_protection_plan,
      subnet,
      dns_servers,
      tags
    ]
  }
}

resource "azurerm_subnet" "shared" {
  name                 = "shared-subnet"
  resource_group_name  = "rg-wwe-${local.environment_sanitized}"
  virtual_network_name = azurerm_virtual_network.wwe_egos.name
  address_prefixes     = [var.shared_subnet_address]
  depends_on = [azurerm_virtual_network.wwe_egos]
  
  delegation {
    name = "delegation"
    service_delegation {
      name     = "Microsoft.Web/serverFarms"
      actions  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}




resource "azurerm_subnet" "pe_subnet" {//"agw_subnet" 
  name                 = "snet_pe"//"snet_agw"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.wwe_egos.name
  address_prefixes     = [var.pe_snet_address_space]

  lifecycle {
    ignore_changes = [
     delegation
    ]
  }
}
