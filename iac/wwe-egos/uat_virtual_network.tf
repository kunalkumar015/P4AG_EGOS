
# ------------------UAT(eastus2)--------------------------------

resource "azurerm_virtual_network" "wwe_egos_uat_eastus2" {
  name                = "vnet-wwe-${local.app_type}-uat-eastus2"
  provider             = azurerm.uat
  resource_group_name = "rg-wwe-uat"
  location            = "eastus2"

  address_space = ["172.22.35.192/27"]
  lifecycle {
    ignore_changes = [
      ddos_protection_plan,
      subnet,
      dns_servers,
      tags
    ]
  }
}


resource "azurerm_subnet" "uat_shared_eastus2" {
  name                 = "webapps-subnet-uat-eastus2"
  provider             = azurerm.uat
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-${local.app_type}-uat-eastus2"
  address_prefixes     = ["172.22.35.192/28"]

  delegation {
    name = "delegation"
    service_delegation {
      name     = "Microsoft.Web/serverFarms"
      actions  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "uat_pe_subnet_eastus2" {
  name                 = "snet_pep_uat_eastus2"
  provider             = azurerm.uat
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-${local.app_type}-uat-eastus2"
  address_prefixes     = ["172.22.35.208/28"]

  lifecycle {
    ignore_changes = [
     delegation
    ]
  }
}



# ------------------UAT(centralus)--------------------------------

resource "azurerm_virtual_network" "wwe_ga_uat_centralus" {
  name                = "vnet-wwe-${local.app_type}-uat-centralus"
  provider             = azurerm.uat
  resource_group_name = "rg-wwe-uat"
  location            = "centralus"

  address_space = ["172.22.39.0/27"]
  lifecycle {
    ignore_changes = [
      ddos_protection_plan,
      subnet,
      dns_servers,
      tags
    ]
  }
}


resource "azurerm_subnet" "uat_shared_centralus" {
  name                 = "webapps-subnet-uat-centralus"
  provider             = azurerm.uat
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-${local.app_type}-uat-centralus"
  address_prefixes     = ["172.22.39.0/28"]

  delegation {
    name = "delegation"
    service_delegation {
      name     = "Microsoft.Web/serverFarms"
      actions  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "uat_agw_subnet_centralus" {
  name                 = "snet_shared_uat"
  provider             = azurerm.uat
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-${local.app_type}-uat-centralus"
  address_prefixes     = ["172.22.39.16/28"]

  lifecycle {
    ignore_changes = [
     delegation
    ]
  }
}
