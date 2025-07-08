
resource "azurerm_cdn_frontdoor_profile" "afdProfile" {
  name                = "afd-webapps-dev-profile"
  resource_group_name = "rg-wwe-dev"
  sku_name            = "Standard_AzureFrontDoor"
  tags = {
    app         = "webapp"
    environment = "dev"
    subproject  = "egos-dev"
  }
}
