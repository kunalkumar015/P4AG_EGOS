
# -------------------eastus2----------------------------------

resource "azurerm_public_ip_prefix" "uat_eastus2" {
  name                = "pip-prefix-wwe-${local.app_type}-uat-eastus2"
  location            = "eastus2"
  provider            = azurerm.uat
  resource_group_name = "rg-wwe-uat"
  prefix_length       = 30
  sku                 = "Standard"
}


resource "azurerm_nat_gateway" "uat_eastus2" {
  name                    = "nat-wwe-${local.app_type}-uat-eastus2"
  location                = "eastus2"
  provider                = azurerm.uat
  resource_group_name     = "rg-wwe-uat"
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4

  
  tags = {
    environment = "uat"
    region      = "eastus2"
    app_type    = local.app_type
  }
}




resource "azurerm_subnet" "uat_private_eastus2" {
  name                 = "sn-private-uat"
  provider             = azurerm.uat
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-egos-uat-eastus2"
  address_prefixes     = [var.shared_subnet_address]


  delegation {
    name = "delegation"
    service_delegation {
      name     = "Microsoft.Web/serverFarms"
      actions  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}



# ------------------centralus-----------------------------

resource "azurerm_public_ip_prefix" "uat_centralus" {
  name                = "pip-prefix-wwe-${local.app_type}-uat-centralus"
  location            = "centralus"
  provider            = azurerm.uat
  resource_group_name = "rg-wwe-uat"
  prefix_length       = 30
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "uat_centralus" {
  name                    = "nat-wwe-${local.app_type}-uat-centralus"
  location                = "centralus"
  provider                = azurerm.uat
  resource_group_name     = "rg-wwe-uat"
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4

  
  tags = {
    environment = "uat"
    region      = "centralus"
    app_type    = local.app_type
  }
}


resource "azurerm_subnet" "uat_private_centralus" {
  name                 = "sn-private-uat"
  provider             = azurerm.uat
  resource_group_name  = "rg-wwe-uat"
  virtual_network_name = "vnet-wwe-egos-uat-centralus"
  address_prefixes     = [var.shared_subnet_address]


  delegation {
    name = "delegation"
    service_delegation {
      name     = "Microsoft.Web/serverFarms"
      actions  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}


