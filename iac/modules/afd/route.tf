
resource "azurerm_cdn_frontdoor_route" "afdRoute" {
  name                          = var.route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.afdEndpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.afdOrigin_group.id
  supported_protocols           = ["Http", "Https"]
  patterns_to_match             = ["/*"]
  forwarding_protocol           = "MatchRequest"
  https_redirect_enabled        = true
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.afdOrigin.id]
  enabled                       = true
}

