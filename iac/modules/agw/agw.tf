# resource "azurerm_application_gateway" "agw" {
#   name                     = "agw-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name      = data.azurerm_resource_group.resource_group.name
#   location                 = data.azurerm_resource_group.resource_group.location
#   frontend_ip_configuration {
#     name                 = "frontend-ip"
#     public_ip_address_id = azurerm_public_ip.public_ip.id
#   }
#   backend_address_pool {
#     name = "backend-pool"
#     backend {
#       fqdn = "example.com"
#     }
#   }
#   backend_http_settings {
#     name                    = "backend-http-settings"
#     cookie_based_affinity   = "Disabled"
#     port                    = 80
#     protocol                = "Http"
#     request_timeout {
#       seconds = 20
#     }
#   }
#   http_listener {
#     name                            = "http-listener"
#     frontend_ip_configuration_name = "frontend-ip"
#     frontend_port_name             = "frontend-port"
#     protocol                        = "Http"
#   }
#   request_routing_rule {
#     name                       = "route-to-backend"
#     rule_type                  = "Basic"
#     http_listener_name         = "http-listener"
#     backend_address_pool_name  = "backend-pool"
#     backend_http_settings_name = "backend-http-settings"
#   }
# }
