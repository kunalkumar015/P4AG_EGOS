# resource "azurerm_cdn_frontdoor_origin" "afd_origins" {
#   for_each = var.afd_origins

#   name                           = each.key
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.afd_origin_groups[each.value.origin_group_key].id
#   host_name                      = each.value.host_name
#   http_port                      = each.value.http_port
#   https_port                     = each.value.https_port
#   enabled                        = each.value.enabled
#   priority                       = each.value.priority
#   weight                         = each.value.weight
#   certificate_name_check_enabled = true
# }


resource "azurerm_cdn_frontdoor_origin" "afdOrigin" {
  name                          = var.origin_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.afdOrigin_group.id
  host_name                     = var.origin_hostname
  http_port                     = 80
  https_port                    = 443
  priority                      = 1
  weight                        = 1000
  enabled                       = true
  certificate_name_check_enabled = true
}