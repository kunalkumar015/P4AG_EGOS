# resource "azurerm_frontdoor" "afd" {
#   name                     = "afd-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name      = data.azurerm_resource_group.resource_group.name
#   location                 = data.azurerm_resource_group.resource_group.location
#   friendly_name            = "Front Door for ${local.app_type}"
#   routing_rule {
#     name                        = "route-to-backend"
#     accepted_protocols          = ["Https"]
#     patterns_to_match           = ["/*"]
#     route_configuration {
#       forwarding_configuration {
#         backend_pool_id = azurerm_frontdoor_backend_pool.backend_pool.id
#       }
#     }
#   }
#   backend_pool {
#     name = "backend-pool"
#     backend {
#       host_header = "example.com"
#       address     = "example.com"
#       priority    = 1
#       weight      = 50
#     }
#   }
# }


# resource "azurerm_cdn_frontdoor_profile" "afdProfile" {
#   name                = var.profile_name
#   resource_group_name = var.resource_group
#   sku_name            = "Premium_AzureFrontDoor"
# }


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
