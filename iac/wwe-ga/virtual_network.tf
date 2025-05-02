resource "azurerm_virtual_network" "wwe_ga" {
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



resource "azurerm_subnet" "consolidated" {
  name                 = "snet-wwe-ga"
  resource_group_name  = "rg-wwe-${local.environment_sanitized}"
  virtual_network_name = azurerm_virtual_network.wwe_ga.name
  address_prefixes     = [var.consolidated_subnet_address]
  lifecycle {
    ignore_changes = [
     #delegation
    ]
  }
    
  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# # resource "azurerm_subnet" "private_endpoint" {
# #   name                 = "snet-privateendpoints"
# #   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
# #   virtual_network_name = azurerm_virtual_network.wwe_ga.name
# #   address_prefixes     = [var.privateendpoints_address_space ]
# # }

# # resource "azurerm_subnet" "appgw_web" {
# #   name                 = "snet-appgateway-web"
# #   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
# #   virtual_network_name = azurerm_virtual_network.wwe_ga.name
# #   address_prefixes     = [var.appgw_subnet_web_address_space]
# # }

# # resource "azurerm_subnet" "appgw_dash" {
# #   name                 = "snet-appgateway-dash"
# #   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
# #   virtual_network_name = azurerm_virtual_network.wwe_ga.name
# #   address_prefixes     = [var.appgw_subnet_dash_address_space]
# # }

# resource "azurerm_subnet" "webservices" {
#   name                 = "snet-webservices"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.webservices_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }
# resource "azurerm_subnet" "dashboard" {
#   name                 = "snet-dashboard"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.dashboard_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "carthandoff" {
#   name                 = "snet-carthandoff"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.carthandoff_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "classifying" {
#   name                 = "snet-classifying"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.classifying_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "webjobs" {
#   name                 = "snet-webjobs"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.webjobs_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }
# resource "azurerm_subnet" "globalcheckout" {
#   name                 = "snet-globalcheckout"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.globalcheckout_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "hangfire" {
#   name                 = "snet-hangfire"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.hangfire_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "shopifyintegrationws" {
#   name                 = "snet-shopifyintegrationws"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.shopifyintegrationws_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "tracking" {
#   name                 = "snet-tracking"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.tracking_address_space]
#   lifecycle {
#     ignore_changes = [
#      #delegation
#     ]
#   }
    
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }
# resource "azurerm_subnet" "iaas" {
#   name                 = "snet-iaas"
#   resource_group_name  = "rg-wwe-${local.environment_sanitized}"
#   virtual_network_name = azurerm_virtual_network.wwe_ga.name
#   address_prefixes     = [var.iaas_address_space]
# }