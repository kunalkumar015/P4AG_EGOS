
module "afd" {
  source                  = "../modules/afd"
  afd_profile_name        = "afd-webapp-dev-profile"
  afd_endpoint_name       = "afd-webapp-dev-endpoint"
  afd_sku                 = "Standard_AzureFrontDoor"
  origin_group_name       = "webapp-dev-origin-group"
  origin_name             = "webapp-dev-origin"
  origin_hostname         = "ase2-wwe-egos-egosapi-dev-eastus2.azurewebsites.net"  
  route_name              = "webapp-dev-route"
  resource_group_name     = var.resource_group_name
  location                = var.location

  # Required inputs
  organization_suffix     = "wwe"
  kv_secret_version       = "cb172d73f5ad486da950bd056abb415a"
  custom_domain_hostname  = "yellow.wweconomy.ups.com"   //gfegosapi.wweconomy.ups.com         
  app_type                = "egos"
  custom_domain_name      = "egosapp-dev-custom-domain" //yellow.wweconomy.ups.com
  tenant_id               = var.tenant_id
  profile_name            = "afd-webapp-dev-profile"
  waf_policy_id           = var.waf_policy_id
  kv_id                   = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.KeyVault/vaults/kv2-wwe-dev-eastus2"
  waf_policies            = var.waf_policies
  resource_group          = var.resource_group_name
  endpoint_name           = "afd-webapp-dev-endpoint"
  kv_secret_name          = "test"
  secret_name             = "dev-cert-eastus2"
  region                  = var.location
  security_policy_name    = "afd-webapp-dev-security-policy"
  environment             = "dev"
  # depends_on = [module.keyvault]
}









# module "afd" {
#   source = "../modules/afd"
#   location              = var.location
#   afd_profile_name      = var.afd_profile_name
#   endpoint_name         = "ep-wwe"
#   afd_origins           = local.afd_origins
#   afd_origin_groups     = local.afd_origin_groups
#   afd_routes            = local.afd_routes
#   afd_secrets           = local.afd_secrets
#   afd_security_policies = local.afd_security_policies
# }





# # module "afd" {
# #   source   = "../modules/afd"
# #   environment              = local.environment_sanitized
# #   organization_suffix      = "wwe"
# #   app_type                 = local.app_type
# #   region                   = local.region_sanitized
# #   tenant_id                = var.tenant_id
# # }




# ------------------------frontdoor profile---------------------------------------

# resource "azurerm_cdn_frontdoor_profile" "fd" {
#   name                     = "afd-${organization_suffix}-dev"
#   resource_group_name      = "rg-network-dev"
#   response_timeout_seconds = 60
#   sku_name                 = "Premium_AzureFrontDoor"
#   tags = {
#     environment = "dev"
#   }

# }

# #------------------------frontdoor endpoint---------------------------------------


# resource "azurerm_cdn_frontdoor_endpoint" "fde" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   enabled                  = true
#   name                     = "ep-wwe"
#   tags                     = {}
# }








# #------------------------origins---------------------------------------


# resource "azurerm_cdn_frontdoor_origin" "egos-dashboard" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-dashboard"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-egos-dashboard-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-egos-dashboard-eastus2"
#   origin_host_header             = "ase-wwe-egos-dashboard-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# resource "azurerm_cdn_frontdoor_origin" "egos-tracking" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tracking"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-egos-opstrackingwebapi-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-egos-tracking-eastus2"
#   origin_host_header             = "ase-wwe-egos-opstrackingwebapi-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# resource "azurerm_cdn_frontdoor_origin" "egos-webservices" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-webservices"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-egos-webservices-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-egos-webservices-eastus2"
#   origin_host_header             = "ase-wwe-egos-webservices-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# resource "azurerm_cdn_frontdoor_origin" "egos-hangfire" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-hangfire"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-egos-hangfire-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-egos-hangfire-eastus2"
#   origin_host_header             = "ase-wwe-egos-hangfire-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }


# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-shop/origins/origin-ga-shop-eastus2"
# resource "azurerm_cdn_frontdoor_origin" "ga-shop" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-shop"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-ga-shopifyintegrationws-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-ga-shop-eastus2"
#   origin_host_header             = "ase-wwe-ga-shopifyintegrationws-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-tracking/origins/origin-ga-tracking-eastus2"
# resource "azurerm_cdn_frontdoor_origin" "ga-tracking" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-tracking"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-ga-tracking-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-ga-tracking-eastus2"
#   origin_host_header             = "ase-wwe-ga-tracking-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-globalcheckout/origins/origin-ga-globalcheckout-eastus2"
# resource "azurerm_cdn_frontdoor_origin" "ga-globalcheckout" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-globalcheckout"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-ga-globalcheckout-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-ga-globalcheckout-eastus2"
#   origin_host_header             = "ase-wwe-ga-globalcheckout-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# resource "azurerm_cdn_frontdoor_origin" "ga-addinfo" { #ga-carthandoff
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-addinfo"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-ga-carthandoff-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "ase-wwe-ga-carthandoff-dev-eastus2"
#   origin_host_header             = "ase-wwe-ga-carthandoff-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# resource "azurerm_cdn_frontdoor_origin" "ga-hangfire" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-hangfire"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-ga-hangfire-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-ga-hangfire-eastus2"
#   origin_host_header             = "ase-wwe-ga-hangfire-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# resource "azurerm_cdn_frontdoor_origin" "egos-tradedirect" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tradedirect"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-egos-tradedirect-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "rt-egos-tradedirect"
#   origin_host_header             = "ase-wwe-egos-tradedirect-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/nuget/origins/origin-shared-nuget-eastus2"
# resource "azurerm_cdn_frontdoor_origin" "nuget" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/nuget"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-shared-nuget-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-shared-nuget-eastus2"
#   origin_host_header             = "ase-wwe-shared-nuget-dev-eastus2.azurewebsites.net"
#   priority                       = 2
#   weight                         = 1000
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-egosapi/origins/origin-egos-egosapi-dev-eastus2"
# resource "azurerm_cdn_frontdoor_origin" "egos-egosapi" {
#   cdn_frontdoor_origin_group_id  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-egosapi"
#   certificate_name_check_enabled = true
#   enabled                        = true
#   host_name                      = "ase-wwe-egos-egosapi-dev-eastus2.azurewebsites.net"
#   http_port                      = 80
#   https_port                     = 443
#   name                           = "origin-egos-egosapi-dev-eastus2"
#   origin_host_header             = "ase-wwe-egos-egosapi-dev-eastus2.azurewebsites.net"
#   priority                       = 1
#   weight                         = 1000
# }












# #------------------------origin_groups---------------------------------------


# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-hangfire"
# resource "azurerm_cdn_frontdoor_origin_group" "ga_hangfire" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "ga-hangfire"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/Schedule"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-globalcheckout"
# resource "azurerm_cdn_frontdoor_origin_group" "ga_globalcheckout" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "ga-globalcheckout"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/v1"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-webservices"
# resource "azurerm_cdn_frontdoor_origin_group" "egos_webservices" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "egos-webservices"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/Help/Api/POST-api-EmailNotifications-CreateOrUpdatePrealert"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-dashboard"
# resource "azurerm_cdn_frontdoor_origin_group" "egos_dashboard" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "egos-dashboard"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/Account/Account"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tradedirect"
# resource "azurerm_cdn_frontdoor_origin_group" "egos_tradedirect" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "egos-tradedirect"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/Help/Api/POST-api-TDCreateParcel"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-egosapi"
# resource "azurerm_cdn_frontdoor_origin_group" "egos_egosapi" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "egos-egosapi"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = true
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/Help/Examples"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tracking"
# resource "azurerm_cdn_frontdoor_origin_group" "egos_tracking" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "egos-tracking"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-tracking"
# resource "azurerm_cdn_frontdoor_origin_group" "ga_tracking" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "ga-tracking"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/en/merchant-claims"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-addinfo"
# resource "azurerm_cdn_frontdoor_origin_group" "ga_addinfo" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "ga-addinfo"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-hangfire"
# resource "azurerm_cdn_frontdoor_origin_group" "egos_hangfire" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "egos-hangfire"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/Account/Login"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/nuget"
# resource "azurerm_cdn_frontdoor_origin_group" "nuget" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "nuget"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/"
#     protocol            = "Http"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-shop"
# resource "azurerm_cdn_frontdoor_origin_group" "ga_shop" {
#   cdn_frontdoor_profile_id                                  = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                                                      = "ga-shop"
#   restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
#   session_affinity_enabled                                  = false
#   health_probe {
#     interval_in_seconds = 100
#     path                = "/v1"
#     protocol            = "Https"
#     request_type        = "HEAD"
#   }
#   load_balancing {
#     additional_latency_in_milliseconds = 50
#     sample_size                        = 4
#     successful_samples_required        = 3
#   }
# }









# #--------------------------frontdoor_route-------------------------------------

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_egos_api" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egosapi-yellow-wweconomy-ups-com-e6ee"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-egosapi"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "HttpsOnly"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-egos-api"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_nuget" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/nuget-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/nuget"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-nuget"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_ga_addinfo" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-addinfo-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-addinfo"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-ga-addinfo"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_ga_shop" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-shop-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-shop"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-ga-shop"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_ga_hangfire" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-hangfire-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-hangfire"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-ga-hangfire"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_egos_tracking" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-tracking-api-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tracking"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-egos-tracking"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_egos_hangfire" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-hangfire-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-hangfire"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-egos-hangfire"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_ga_globalcheckout" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-shop-globalcheckout-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-globalcheckout"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-ga-globalcheckout"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_egos_dashboard" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-dashboard-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-dashboard"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-egos-dashboard"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_egos_tradedirect" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/tradedirect-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tradedirect"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-egos-tradedirect"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_ga_tracking" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-tracking-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-tracking"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-ga-tracking"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_route" "rt_egos_webservices" {
#   cdn_frontdoor_custom_domain_ids = ["/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-webservices-yellow-wweconomy-ups-com"]
#   cdn_frontdoor_endpoint_id       = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/afdEndpoints/ep-wwe"
#   cdn_frontdoor_origin_group_id   = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-webservices"
#   cdn_frontdoor_origin_ids        = null
#   cdn_frontdoor_origin_path       = null
#   cdn_frontdoor_rule_set_ids      = []
#   enabled                         = true
#   forwarding_protocol             = "MatchRequest"
#   https_redirect_enabled          = true
#   link_to_default_domain          = false
#   name                            = "rt-egos-webservices"
#   patterns_to_match               = ["/*"]
#   supported_protocols             = ["Http", "Https"]
# }










# #------------------------frontdoor secrets---------------------------------------


# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/secrets/kv-wwe-dev-eastus2-yellow-wweconomy-ups-com-latest"
# resource "azurerm_cdn_frontdoor_secret" "kv_wwe_dev_eastus2_yellow_wweconomy_ups_com_latest" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "kv-wwe-dev-eastus2-yellow-wweconomy-ups-com-latest"
#   secret {
#     customer_certificate {
#       key_vault_certificate_id = "https://kv-wwe-dev-eastus2.vault.azure.net/certificates/yellow-wweconomy-ups-com"
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/secrets/kv-wwe-dev-eastus2-tradedirect-latest"
# resource "azurerm_cdn_frontdoor_secret" "kv_wwe_dev_eastus2_tradedirect_latest" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "kv-wwe-dev-eastus2-tradedirect-latest"
#   secret {
#     customer_certificate {
#       key_vault_certificate_id = "https://kv-wwe-dev-eastus2.vault.azure.net/certificates/tradedirect"
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/secrets/kv-wwe-dev-eastus2-wwe-dev-latest"
# resource "azurerm_cdn_frontdoor_secret" "kv_wwe_dev_eastus2_wwe_dev_latest" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "kv-wwe-dev-eastus2-wwe-dev-latest"
#   secret {
#     customer_certificate {
#       key_vault_certificate_id = "https://kv-wwe-dev-eastus2.vault.azure.net/certificates/wwe-dev"
#     }
#   }
# }










# #------------------------frontdoor security policy---------------------------------------

# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea60ee" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea60ee"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafLogsDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/logs-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea604b"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea604b" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea604b"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosWebservicesDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-webservices-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/sp-egosapi-dev"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_egosapi_dev" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "sp-egosapi-dev"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosApiDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egosapi-yellow-wweconomy-ups-com-e6ee"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a0b4"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a0b4" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a0b4"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosTrackingDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-tracking-api-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a0e0"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a0e0" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a0e0"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaAddinfoDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-addinfo-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a086"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a086" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a086"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosDashboardDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-dashboard-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea6024"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea6024" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea6024"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosHangfireDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-hangfire-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea6097"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea6097" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea6097"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaShopDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-shop-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a106"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a106" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a106"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaGlobalDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-shop-globalcheckout-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a159"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a159" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a159"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafNugetDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/nuget-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea6072"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea6072" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea6072"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaHangfireDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-hangfire-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a12c"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a12c" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a12c"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaTrackingDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-tracking-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourcegroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea60c1"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea60c1" {
#   cdn_frontdoor_profile_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea60c1"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/waftradeDirectDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-network-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/tradedirect-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }
