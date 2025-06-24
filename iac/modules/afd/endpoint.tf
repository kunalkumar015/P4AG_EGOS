
# resource "azurerm_cdn_frontdoor_endpoint" "afdEndpoints" {
#   name                      = var.endpoint_name
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afdProfile.id

#   dynamic "secret" {
#     for_each = var.afd_secrets
#     content {
#       secret_name   = secret.key
#       secret_type   = secret.value.secret_type
#       secret_value  = secret.value.secret_value
#     }
  
# }
# }


resource "azurerm_cdn_frontdoor_endpoint" "afdEndpoint" {
  name                     = var.afd_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afdProfile.id
  enabled                  = true
  tags                     = var.tags
}
