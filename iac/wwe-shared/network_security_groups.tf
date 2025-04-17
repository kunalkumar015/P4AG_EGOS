#delete 1124 recreate 0125
# resource "azurerm_network_security_group" "private_endpoint" {
#   name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.private_endpoint.name, "snet-", "")}"
#   resource_group_name  = azurerm_virtual_network.wwe_shared.resource_group_name
#   location            = azurerm_resource_group.wwe_shared.location

#       lifecycle {
#     ignore_changes = [
#       tags
#     ]
#   }
# }
# resource "azurerm_subnet_network_security_group_association" "private_endpoint" {
#   subnet_id                 = azurerm_subnet.private_endpoint.id
#   network_security_group_id = azurerm_network_security_group.private_endpoint.id

# }