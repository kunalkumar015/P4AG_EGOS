
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

resource "azurerm_subnet_nat_gateway_association" "uat_eastus2_assoc" {
  subnet_id      = azurerm_subnet.uat_shared_eastus2.id
  nat_gateway_id = azurerm_nat_gateway.uat_eastus2.id

  depends_on = [
    azurerm_subnet.uat_shared_eastus2,
    azurerm_nat_gateway.uat_eastus2
  ]
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


resource "azurerm_subnet_nat_gateway_association" "uat_centralus_assoc" {
  subnet_id      = azurerm_subnet.uat_shared_centralus.id
  nat_gateway_id = azurerm_nat_gateway.uat_centralus.id

  depends_on = [
    azurerm_subnet.uat_shared_centralus,
    azurerm_nat_gateway.uat_centralus
  ]
}



