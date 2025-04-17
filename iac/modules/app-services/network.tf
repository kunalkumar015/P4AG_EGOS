resource "azurerm_network_security_group" "nsg" {
  name                 = "nsg-wwe-${local.app_type}-${var.app_name}-${local.environment_sanitized}-${local.region_sanitized}"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  location             = data.azurerm_resource_group.resource_group.location
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "nsg-asso" {
  subnet_id                 = data.azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
resource "azurerm_subnet_nat_gateway_association" "natgw" {
  subnet_id      = data.azurerm_subnet.subnet.id
  nat_gateway_id = data.azurerm_nat_gateway.nat_gw.id
}
# resource "azurerm_app_service_virtual_network_swift_connection" "vnet-int" {
#   app_service_id = azurerm_windows_web_app.windows_app.id
#   subnet_id      = data.azurerm_subnet.subnet.id
# }