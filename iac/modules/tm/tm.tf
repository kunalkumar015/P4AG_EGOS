# resource "azurerm_traffic_manager_profile" "tm" {
#   name                   = "tm-${local.app_type}-${local.environment_sanitized}-${local.region_sanitized}"
#   resource_group_name    = data.azurerm_resource_group.resource_group.name
#   traffic_routing_method = "Performance"
#   dns_config {
#     relative_name = "tm-${local.app_type}"
#     ttl           = 60
#   }
#   monitor_config {
#     protocol                     = "Http"
#     port                         = 80
#     path                         = "/"
#     interval_in_seconds          = 30
#     timeout_in_seconds           = 10
#     tolerated_number_of_failures = 3
#   }
# }

# resource "azurerm_traffic_manager_endpoint" "tm_endpoint" {
#   name                = "endpoint-${local.app_type}"
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   profile_name        = azurerm_traffic_manager_profile.tm.name
#   type                = "ExternalEndpoints"
#   target              = "example.com"
#   endpoint_location   = local.region_sanitized
#   weight              = 100
# }
