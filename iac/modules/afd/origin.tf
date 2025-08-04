# resource "azurerm_cdn_frontdoor_origin" "afdOrigin" {
#   name                          = var.origin_name
#   cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.afdOrigin_group.id
#   host_name                     = var.origin_hostname
#   http_port                     = 80
#   https_port                    = 443
#   priority                      = 1
#   weight                        = 1000
#   enabled                       = true
#   certificate_name_check_enabled = true
# }