
resource "azurerm_app_service_virtual_network_swift_connection" "vnet-int" {
  app_service_id = azurerm_windows_web_app.windows_app.id
  subnet_id      = var.subnet_id
}