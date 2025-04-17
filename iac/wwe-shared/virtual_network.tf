
resource "azurerm_virtual_network" "wwe_shared" {
  name                = "vnet-wwe-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location

  address_space = [var.vnet_address_space]
  # dns_servers   = [data.azurerm_firewall.hub.ip_configuration[0].private_ip_address]
  lifecycle {
    ignore_changes = [
      ddos_protection_plan,
      subnet,
      dns_servers,
      tags
    ]
  }
}

resource "azurerm_subnet" "private_endpoint" {
  name                 = "snet-privateendpoints"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.wwe_shared.name
  address_prefixes     = [var.privateendpoints_address_space ]
}

# resource "azurerm_virtual_network" "wwe_devops" {
#   name                = "vnet-wwe-devops-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name = azurerm_resource_group.wwe_devops.name
#   location            = azurerm_resource_group.wwe_devops.location

#   address_space = [var.vnet_address_space_devops]
#   # dns_servers   = [data.azurerm_firewall.hub.ip_configuration[0].private_ip_address]
#   lifecycle {
#     ignore_changes = [
#       ddos_protection_plan,
#       subnet,
#       dns_servers,
#       tags
#     ]
#   }
# }

# resource "azurerm_subnet" "devops_agent" {
#   name                 = "snet-devops"
#   resource_group_name  = azurerm_virtual_network.wwe_devops.resource_group_name
#   virtual_network_name = azurerm_virtual_network.wwe_devops.name
#   address_prefixes     = [var.devops_address_space ]
# }