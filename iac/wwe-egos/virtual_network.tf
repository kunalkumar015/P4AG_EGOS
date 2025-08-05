resource "azurerm_virtual_network" "wwe_egos" {
  name                = "vnet-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name = "rg-wwe-${local.environment_sanitized}"
  location            = data.azurerm_resource_group.resource_group.location

  address_space = [var.vnet_address_space]
  lifecycle {
    ignore_changes = [
      ddos_protection_plan,
      subnet,
      dns_servers,
      tags
    ]
  }
}

resource "azurerm_subnet" "webapps" {
  name                 = "webapps-subnet"
  resource_group_name  = "rg-wwe-${local.environment_sanitized}"
  virtual_network_name = azurerm_virtual_network.wwe_egos.name
  address_prefixes     = [var.webapps_subnet_address]
  depends_on = [azurerm_virtual_network.wwe_egos]
  
  delegation {
    name = "delegation"
    service_delegation {
      name     = "Microsoft.Web/serverFarms"
      actions  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "private_endpoint" {
  name                 = "snet-privateendpoints"
  resource_group_name  = "rg-wwe-${local.environment_sanitized}"
  virtual_network_name = azurerm_virtual_network.wwe_egos.name
  address_prefixes     = [var.privateendpoints_address_space]
  service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
  private_endpoint_network_policies = "Disabled"
  private_link_service_network_policies_enabled = true
  
  lifecycle {
    ignore_changes = [
     delegation
    ]
  }

}


resource "azurerm_subnet" "agw_subnet" {
  name                 = "snet_agw"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.wwe_egos.name
  address_prefixes     = [var.agwsnet_address_space]

  lifecycle {
    ignore_changes = [
     delegation
    ]
  }
}




# resource "azurerm_subnet" "nuget" {
#   name                 = "snet-nuget"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#   lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   }

  
  
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "dao" {
#   name                 = "snet-dao"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#     lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   }
  
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "webservices" {
#   name                 = "snet-webservices"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#    lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   } 
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }
# resource "azurerm_subnet" "dashboard" {
#   name                 = "snet-dashboard"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#     lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }
# resource "azurerm_subnet" "egosapi" {
#   name                 = "snet-egosapi"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#     lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }
# resource "azurerm_subnet" "tradedirect" {
#   name                 = "snet-tradedirect"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#     lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "opstrackingwebapi" {
#   name                 = "snet-opstrackingwebapi"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#     lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }
# resource "azurerm_subnet" "hangfire" {
#   name                 = "snet-hangfire"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#     lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }
# resource "azurerm_subnet" "princepdf" {
#   name                 = "snet-princepdf"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_egos.name
#   address_prefixes     = [var.webapps_subnet_address]
#   service_endpoints    = ["Microsoft.Storage","Microsoft.KeyVault","Microsoft.Web","Microsoft.Sql"]
#   private_endpoint_network_policies = "Disabled"
#     lifecycle {
#     ignore_changes = [
#      delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }
# }