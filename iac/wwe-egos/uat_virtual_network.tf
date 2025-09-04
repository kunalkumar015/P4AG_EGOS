
# ------------------UAT(eastus2)--------------------------------

resource "azurerm_virtual_network" "wwe_ga_uat_eastus2" {
  name                = "vnet-wwe-${local.app_type}-uat-eastus2"
  resource_group_name = "rg-wwe-uat"
  location            = "eastus2"

  address_space = ["172.22.35.192/26"]
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
  name                 = "shared-subnet-uat"
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-${local.app_type}-uat-eastus2"
  address_prefixes     = ["172.22.39.0/27"]

  delegation {
    name = "delegation"
    service_delegation {
      name     = "Microsoft.Web/serverFarms"
      actions  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "uat_agw_subnet_eastus2" {
  name                 = "snet_agw_uat"
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-${local.app_type}-uat-eastus2"
  address_prefixes     = ["172.22.35.224/27"]

  lifecycle {
    ignore_changes = [
     delegation
    ]
  }
}



# ------------------UAT(centralus)--------------------------------

resource "azurerm_virtual_network" "wwe_ga_uat_centralus" {
  name                = "vnet-wwe-${local.app_type}-uat-centralus"
  resource_group_name = "rg-wwe-uat"
  location            = "centralus"

  address_space = ["172.22.39.0/26"]
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
  name                 = "shared-subnet-uat"
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-${local.app_type}-uat-centralus"
  address_prefixes     = ["172.22.39.0/27"]

  delegation {
    name = "delegation"
    service_delegation {
      name     = "Microsoft.Web/serverFarms"
      actions  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "uat_agw_subnet_centralus" {
  name                 = "snet_agw_uat"
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-${local.app_type}-uat-centralus"
  address_prefixes     = ["172.22.39.32/27"]

  lifecycle {
    ignore_changes = [
     delegation
    ]
  }
}
