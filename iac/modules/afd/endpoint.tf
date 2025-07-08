
resource "azurerm_cdn_frontdoor_endpoint" "afdEndpoint" {
  name                     = var.afd_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afdProfile.id
  enabled                  = true
  tags                     = var.tags
}
