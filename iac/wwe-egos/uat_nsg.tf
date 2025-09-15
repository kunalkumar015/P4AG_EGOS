# ----------------------------eastus2-----------------------------------

resource "azurerm_network_security_group" "uat_shared_nsg_eastus2" {
  name                = "nsg-wwe-uat-shared-eastus2"
  provider            = azurerm.uat
  location            = "eastus2"
  resource_group_name = "rg-wwe-uat"

#   security_rule {
#     name                       = "Allow-HTTP-Inbound"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#     description                = "Allow HTTP from Internet"
#   }

  security_rule {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Allow HTTPS from Internet"
  }

  security_rule {
    name                       = "Allow-AppGW-to-WebApps"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "VirtualNetwork"
    description                = "Allow App Gateway access to backend WebApps"
  }

  tags = {
    environment = "uat"
    region      = "eastus2"
    app_type    = local.app_type
  }
}

# Associate NSG with subnet
resource "azurerm_subnet_network_security_group_association" "uat_shared_nsg_assoc_eastus2" {
  provider                  = azurerm.uat
  subnet_id                 = azurerm_subnet.uat_shared_eastus2.id
  network_security_group_id = azurerm_network_security_group.uat_shared_nsg_eastus2.id
}
