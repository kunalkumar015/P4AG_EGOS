# resource "azurerm_cdn_frontdoor_route" "afd_routes" {
#   for_each = var.afd_routes

#   name                            = each.key
#   cdn_frontdoor_endpoint_id      = azurerm_cdn_frontdoor_endpoint.afdEndpoints[each.value.endpoint_name].id
#   cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.afd_origin_groups[each.value.origin_group_name].id
#   cdn_frontdoor_origin_ids       = [
#     for origin_key in var.afd_origin_groups[each.value.origin_group_name].origins :
#     azurerm_cdn_frontdoor_origin.afd_origins[origin_key].id
#   ]

#   supported_protocols            = ["Http", "Https"]
#   patterns_to_match              = each.value.patterns_to_match
#   forwarding_protocol            = each.value.forwarding_protocol

#   https_redirect_enabled         = true
#   link_to_default_domain         = false
# }

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

