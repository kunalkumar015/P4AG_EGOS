
# module "afd" {
#   source                  = "../modules/afd"
#   afd_profile_name        = "afd-dev-profile"
#   afd_endpoint_name       = "ep-afd-wwe-dev-akezd5a3hcd9a0ce"
#   afd_sku                 = "Standard_AzureFrontDoor"
#   origin_group_name       = "webapp-dev-origin-group"
#   origin_name             = "webapp-dev-origin"
#   origin_hostname         = "ase22-wwe-egos-egosapi-dev-eastus2.azurewebsites.net"  
#   route_name              = "webapp-dev-route"
#   resource_group_name     = var.resource_group_name
#   location                = var.location

#   # Required inputs
#   organization_suffix     = "wwe"
#   kv_secret_version       = "b043036676834a6182952d9d5fce5fa6"
#   custom_domain_hostname  = "yellow.wweconomy.ups.com"   //gfegosapi.wweconomy.ups.com         
#   app_type                = "egos"
#   custom_domain_name      = "egosapp-dev-custom-domain" //yellow.wweconomy.ups.com
#   tenant_id               = var.tenant_id
#   profile_name            = "afd-webapp-dev-profile"
#   waf_policy_id           = var.waf_policy_id
#   kv_id                   = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.KeyVault/vaults/kv2-wwe-dev-eastus2-v3"
#   waf_policies            = var.waf_policies
#   resource_group          = var.resource_group_name
#   endpoint_name           = "afd-webapp-dev-endpoint"
#   kv_secret_name          = "afd-secret-dev"
#   secret_name             = "dev-cert-eastus2"
#   region                  = var.location
#   security_policy_name    = "afd-webapp-dev-security-policy"
#   environment             = "dev"
#   depends_on = [module.keyvault]
# }

# ------------------------kv for custom domian---------------------------------------

data "azurerm_key_vault" "kv" {
  name                = "kv2-wwe-dev-eastus2-v3"
  resource_group_name = "rg-wwe-dev"
}

data "azurerm_key_vault_certificate" "yellow_cert" {
  name         = "yellow-wweconomy-ups-com"
  key_vault_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.KeyVault/vaults/kv2-wwe-dev-eastus2-v3"
}



# ------------------------frontdoor profile---------------------------------------

resource "azurerm_cdn_frontdoor_profile" "afd" {
  name                     = "afd-wwe-dev"
  resource_group_name      = var.resource_group_name
  response_timeout_seconds = 60
  sku_name                 = "Premium_AzureFrontDoor"
  tags = {
    environment = "dev"
  }

}

#------------------------frontdoor endpoint---------------------------------------


resource "azurerm_cdn_frontdoor_endpoint" "fde" {
  cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  enabled                  = true
  name                     = "endpoint-afd-wwe-dev"
  tags                     = {}
}


#------------------------origins---------------------------------------


resource "azurerm_cdn_frontdoor_origin" "egos-dashboard" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-dashboard"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-egos-dashboard-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-egos-dashboard-eastus2"
  origin_host_header             = "ase2-wwe-egos-dashboard-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_dashboard
  ]
}

resource "azurerm_cdn_frontdoor_origin" "egos-tracking" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tracking"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-egos-opstrackingwebapi-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-egos-tracking-eastus2"
  origin_host_header             = "ase2-wwe-egos-opstrackingwebapi-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_tracking
  ]
}

resource "azurerm_cdn_frontdoor_origin" "egos-webservices" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-webservices"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-egos-webservices-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-egos-webservices-eastus2"
  origin_host_header             = "ase2-wwe-egos-webservices-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_webservices
  ]
}

resource "azurerm_cdn_frontdoor_origin" "egos-hangfire" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-hangfire"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-egos-hangfire-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-egos-hangfire-eastus2"
  origin_host_header             = "ase2-wwe-egos-hangfire-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_hangfire
  ]
}


# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-shop/origins/origin-ga-shop-eastus2"
resource "azurerm_cdn_frontdoor_origin" "ga-shop" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-shop"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-ga-shopifyintegrationws-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-ga-shop-eastus2"
  origin_host_header             = "ase2-wwe-ga-shopifyintegrationws-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_shop
  ]
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-tracking/origins/origin-ga-tracking-eastus2"
resource "azurerm_cdn_frontdoor_origin" "ga-tracking" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-tracking"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-ga-tracking-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-ga-tracking-eastus2"
  origin_host_header             = "ase2-wwe-ga-tracking-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_tracking
  ]
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-globalcheckout/origins/origin-ga-globalcheckout-eastus2"
resource "azurerm_cdn_frontdoor_origin" "ga-globalcheckout" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-globalcheckout"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-ga-globalcheckout-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-ga-globalcheckout-eastus2"
  origin_host_header             = "ase2-wwe-ga-globalcheckout-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_globalcheckout
  ]
}

resource "azurerm_cdn_frontdoor_origin" "ga-addinfo" { #ga-carthandoff
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-addinfo"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-ga-carthandoff-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "ase2-wwe-ga-carthandoff-dev-eastus2"
  origin_host_header             = "ase2-wwe-ga-carthandoff-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_addinfo
  ]
}

resource "azurerm_cdn_frontdoor_origin" "ga-hangfire" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-hangfire"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-ga-hangfire-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-ga-hangfire-eastus2"
  origin_host_header             = "ase2-wwe-ga-hangfire-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_hangfire
  ]
}

resource "azurerm_cdn_frontdoor_origin" "egos-tradedirect" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tradedirect"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-egos-tradedirect-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "rt-egos-tradedirect"
  origin_host_header             = "ase2-wwe-egos-tradedirect-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_tradedirect
  ]
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/nuget/origins/origin-shared-nuget-eastus2"
resource "azurerm_cdn_frontdoor_origin" "nuget" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/nuget"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-shared-nuget-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-shared-nuget-eastus2"
  origin_host_header             = "ase2-wwe-shared-nuget-dev-eastus2.azurewebsites.net"
  priority                       = 2
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.nuget
  ]

}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-egosapi/origins/origin-egos-egosapi-dev-eastus2"
resource "azurerm_cdn_frontdoor_origin" "egos-egosapi" {
  cdn_frontdoor_origin_group_id  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-egosapi"
  certificate_name_check_enabled = true
  enabled                        = true
  host_name                      = "ase2-wwe-egos-egosapi-dev-eastus2.azurewebsites.net"
  http_port                      = 80
  https_port                     = 443
  name                           = "origin-egos-egosapi-dev-eastus2"
  origin_host_header             = "ase2-wwe-egos-egosapi-dev-eastus2.azurewebsites.net"
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_egosapi
  ]
}

# ase2-wwe-egos-dao-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "egos-dao" {
  name                           = "origin-egos-dao-eastus2"
  host_name                      = "ase2-wwe-egos-dao-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-egos-dao-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.egos_dao.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_dao
  ]
}

# ase2-wwe-egos-egos-tracking-api-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "egos-tracking-api" {
  name                           = "origin-egos-tracking-api-eastus2"
  host_name                      = "ase2-wwe-egos-egos-tracking-api-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-egos-egos-tracking-api-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.egos_tracking_api.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_tracking_api
  ]
}

# ase2-wwe-egos-nuget-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "egos-nuget" {
  name                           = "origin-egos-nuget-eastus2"
  host_name                      = "ase2-wwe-egos-nuget-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-egos-nuget-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.egos_nuget.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.egos_nuget
  ]
}

# ase2-wwe-ga-classifying-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "ga-classifying" {
  name                           = "origin-ga-classifying-eastus2"
  host_name                      = "ase2-wwe-ga-classifying-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-ga-classifying-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.ga_classifying.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_classifying
  ]
}

# ase2-wwe-ga-dashboard-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "ga-dashboard" {
  name                           = "origin-ga-dashboard-eastus2"
  host_name                      = "ase2-wwe-ga-dashboard-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-ga-dashboard-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.ga_dashboard.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_dashboard
  ]
}

# ase2-wwe-ga-label-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "ga-label" {
  name                           = "origin-ga-label-eastus2"
  host_name                      = "ase2-wwe-ga-label-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-ga-label-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.ga_label.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_label
  ]
}

# ase2-wwe-ga-prince-pdf2-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "ga-prince-pdf2" {
  name                           = "origin-ga-prince-pdf2-eastus2"
  host_name                      = "ase2-wwe-ga-prince-pdf2-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-ga-prince-pdf2-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.ga_prince_pdf2.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_prince_pdf2
  ]
}

# ase2-wwe-ga-webservices-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "ga-webservices" {
  name                           = "origin-ga-webservices-eastus2"
  host_name                      = "ase2-wwe-ga-webservices-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-ga-webservices-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.ga_webservices.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_webservices
  ]

}

# ase2-wwe-ga-webjobs-dev-eastus2
resource "azurerm_cdn_frontdoor_origin" "ga-webjobs" {
  name                           = "origin-ga-webjobs-eastus2"
  host_name                      = "ase2-wwe-ga-webjobs-dev-eastus2.azurewebsites.net"
  origin_host_header             = "ase2-wwe-ga-webjobs-dev-eastus2.azurewebsites.net"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.ga_webjobs.id
  certificate_name_check_enabled = true
  enabled                        = true
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.ga_webjobs
  ]
}



#------------------------origin_groups---------------------------------------


# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-hangfire"
resource "azurerm_cdn_frontdoor_origin_group" "ga_hangfire" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "ga-hangfire"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-globalcheckout"
resource "azurerm_cdn_frontdoor_origin_group" "ga_globalcheckout" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "ga-globalcheckout"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-webservices"
resource "azurerm_cdn_frontdoor_origin_group" "egos_webservices" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "egos-webservices"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-dashboard"
resource "azurerm_cdn_frontdoor_origin_group" "egos_dashboard" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "egos-dashboard"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tradedirect"
resource "azurerm_cdn_frontdoor_origin_group" "egos_tradedirect" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "egos-tradedirect"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-egosapi"
resource "azurerm_cdn_frontdoor_origin_group" "egos_egosapi" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "egos-egosapi"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = true
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-tracking"
resource "azurerm_cdn_frontdoor_origin_group" "egos_tracking" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "egos-tracking"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-tracking"
resource "azurerm_cdn_frontdoor_origin_group" "ga_tracking" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "ga-tracking"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-addinfo"
resource "azurerm_cdn_frontdoor_origin_group" "ga_addinfo" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "ga-addinfo"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/egos-hangfire"
resource "azurerm_cdn_frontdoor_origin_group" "egos_hangfire" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "egos-hangfire"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/nuget"
resource "azurerm_cdn_frontdoor_origin_group" "nuget" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "nuget"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Http"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/originGroups/ga-shop"
resource "azurerm_cdn_frontdoor_origin_group" "ga_shop" {
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                                                      = "ga-shop"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false
  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }
  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "egos_dao" {
  name                                                      = "egos-dao"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = true

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "egos_tracking_api" {
  name                                                      = "egos-tracking-api"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "egos_nuget" {
  name                                                      = "egos-nuget"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Http"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "ga_classifying" {
  name                                                      = "ga-classifying"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "ga_dashboard" {
  name                                                      = "ga-dashboard"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "ga_label" {
  name                                                      = "ga-label"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "ga_prince_pdf2" {
  name                                                      = "ga-prince-pdf2"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "ga_webservices" {
  name                                                      = "ga-webservices"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "ga_webjobs" {
  name                                                      = "ga-webjobs"
  cdn_frontdoor_profile_id                                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 0
  session_affinity_enabled                                  = false

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}



# # --------------------------custom_domain-------------------------------------

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_dashboard" {
#   name                      = "egos-dashboard-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-dashboard.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_tracking" {
#   name                      = "egos-tracking-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-tracking.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_webservices" {
#   name                      = "egos-webservices-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-webservices.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_globalcheckout" {
#   name                      = "ga-globalcheckout-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-globalcheckout.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "nuget" {
#   name                      = "nuget-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "nuget.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_addinfo" {
#   name                      = "ga-addinfo-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-addinfo.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_tradedirect" {
#   name                      = "egos-tradedirect-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-tradedirect.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_hangfire" {
#   name                      = "ga-hangfire-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-hangfire.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_hangfire" {
#   name                      = "egos-hangfire-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-hangfire.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_egosapi" {
#   name                      = "egos-egosapi-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-egosapi.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_dao" {
#   name                      = "egos-dao-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-dao.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_tracking_api" {
#   name                      = "egos-tracking-api-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-tracking-api.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "egos_nuget" {
#   name                      = "egos-nuget-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "egos-nuget.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_classifying" {
#   name                      = "ga-classifying-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-classifying.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_dashboard" {
#   name                      = "ga-dashboard-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-dashboard.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_label" {
#   name                      = "ga-label-yellow"
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-label.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_prince_pdf2" {
#   name                      = "ga-prince-pdf2-yellow"
#   cdn_frontdoor_profile_id   = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-prince-pdf2.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_webservices" {
#   name                      = "ga-webservices-yellow"
#   cdn_frontdoor_profile_id   = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-webservices.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_webjobs" {
#   name                      = "ga-webjobs-yellow"
#   cdn_frontdoor_profile_id   = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-webjobs.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_shop" {
#   name                      = "ga-shop-yellow"
#   cdn_frontdoor_profile_id   = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-shop.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }

# resource "azurerm_cdn_frontdoor_custom_domain" "ga_tracking" {
#   name                      = "ga-tracking-yellow"
#   cdn_frontdoor_profile_id   = azurerm_cdn_frontdoor_profile.afd.id
#   host_name                 = "ga-tracking.yellow.wweconomy.ups.com"

#   tls {
#     certificate_type        = "CustomerCertificate"
#     minimum_tls_version     = "TLS12"
#     cdn_frontdoor_secret_id = data.azurerm_key_vault_certificate.yellow_cert.secret_id
#   }
# }





# --------------------------frontdoor_route-------------------------------------
resource "azurerm_cdn_frontdoor_route" "rt_egos_api" {
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.egos_egosapi.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.egos-egosapi.id]
  cdn_frontdoor_origin_path     = ""
  cdn_frontdoor_rule_set_ids    = []
  enabled                       = true
  forwarding_protocol           = "HttpsOnly"
  https_redirect_enabled        = true
  link_to_default_domain        = true
  name                          = "rt-egos-api"
  patterns_to_match             = ["/egos-api/*"]
  supported_protocols           = ["Http", "Https"]
  # No custom domain linked here, keeps link_to_default_domain true
}

resource "azurerm_cdn_frontdoor_route" "rt_nuget" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.nuget.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.nuget.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-nuget"
  patterns_to_match              = ["/nuget/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.nuget.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_ga_addinfo" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.ga_addinfo.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.ga-addinfo.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-ga-addinfo"
  patterns_to_match              = ["/ga-addinfo/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.ga_addinfo.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_ga_hangfire" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.ga_hangfire.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.ga-hangfire.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-ga-hangfire"
  patterns_to_match              = ["/ga-hangfire/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.ga_hangfire.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_egos_tracking" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.egos_tracking.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.egos-tracking.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-egos-tracking"
  patterns_to_match              = ["/egos-tracking/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.egos_tracking.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_egos_hangfire" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.egos_hangfire.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.egos-hangfire.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-egos-hangfire"
  patterns_to_match              = ["/egos-hangfire/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.egos_hangfire.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_ga_globalcheckout" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.ga_globalcheckout.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.ga-globalcheckout.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-ga-globalcheckout"
  patterns_to_match              = ["/ga-globalcheckout/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.ga_globalcheckout.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_egos_dashboard" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.egos_dashboard.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.egos-dashboard.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-egos-dashboard"
  patterns_to_match              = ["/egos-dashboard/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.egos_dashboard.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_egos_tradedirect" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.egos_tradedirect.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.egos-tradedirect.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-egos-tradedirect"
  patterns_to_match              = ["/egos-tradedirect/*"]
  supported_protocols            = ["Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.egos_tradedirect.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_ga_tracking" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.ga_tracking.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.egos-tracking.id] # Double-check origin correctness!
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-ga-tracking"
  patterns_to_match              = ["/ga-tracking/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.ga_tracking.id]
}

resource "azurerm_cdn_frontdoor_route" "rt_egos_webservices" {
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.fde.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.egos_webservices.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.egos-webservices.id]
  cdn_frontdoor_origin_path       = ""
  cdn_frontdoor_rule_set_ids      = []
  enabled                        = true
  forwarding_protocol            = "MatchRequest"
  https_redirect_enabled         = true
  link_to_default_domain         = false
  name                           = "rt-egos-webservices"
  patterns_to_match              = ["/egos-webservices/*"]
  supported_protocols            = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.egos_webservices.id]
}



#------------------------frontdoor waf---------------------------------------

resource "azurerm_cdn_frontdoor_firewall_policy" "waf_policy" {
  name                = "afdWafPolicy"
  resource_group_name = var.resource_group_name
  sku_name            = "Premium_AzureFrontDoor"
  mode                = "Prevention"

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
    action  = "Block"
  }
}




#------------------------frontdoor secrets---------------------------------------


# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/secrets/kv2-wwe-dev-eastus2-v3-yellow-wweconomy-ups-com-latest"
resource "azurerm_cdn_frontdoor_secret" "kv_wwe_dev_eastus2_yellow_wweconomy_ups_com_latest" {
  cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                     = "kv2-wwe-dev-eastus2-v3-yellow-wweconomy-ups-com-latest"
  secret {
    customer_certificate {
      key_vault_certificate_id = data.azurerm_key_vault_certificate.yellow_cert.id
    }
  }
}


# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/secrets/kv2-wwe-dev-eastus2-v3-tradedirect-latest"
resource "azurerm_cdn_frontdoor_secret" "kv_wwe_dev_eastus2_tradedirect_latest" {
  cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                     = "kv2-wwe-dev-eastus2-v3-tradedirect-latest"
  secret {
    customer_certificate {
      key_vault_certificate_id = data.azurerm_key_vault_certificate.yellow_cert.id
    }
  }
}

# __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/secrets/kv2-wwe-dev-eastus2-v3-wwe-dev-latest"
resource "azurerm_cdn_frontdoor_secret" "kv_wwe_dev_eastus2_wwe_dev_latest" {
  cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
  name                     = "kv2-wwe-dev-eastus2-v3-wwe-dev-latest"
  secret {
    customer_certificate {
      key_vault_certificate_id = data.azurerm_key_vault_certificate.yellow_cert.id
    }
  }
}










# #------------------------frontdoor security policy---------------------------------------

# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea60ee" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea60ee"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafLogsDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/logs-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea604b"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea604b" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea604b"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosWebservicesDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-webservices-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/sp-egosapi-dev"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_egosapi_dev" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "sp-egosapi-dev"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosApiDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egosapi-yellow-wweconomy-ups-com-e6ee"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a0b4"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a0b4" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a0b4"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosTrackingDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-tracking-api-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a0e0"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a0e0" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a0e0"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaAddinfoDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-addinfo-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a086"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a086" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a086"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosDashboardDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-dashboard-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea6024"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea6024" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea6024"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafEgosHangfireDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/egos-hangfire-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea6097"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea6097" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea6097"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaShopDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-shop-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a106"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a106" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a106"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaGlobalDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-shop-globalcheckout-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a159"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a159" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a159"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafNugetDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/nuget-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea6072"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea6072" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea6072"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaHangfireDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-hangfire-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/97bfe544-ef9f-4f60-b64f-ad493a43a12c"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_97bfe544_ef9f_4f60_b64f_ad493a43a12c" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "97bfe544-ef9f-4f60-b64f-ad493a43a12c"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/wafGaTrackingDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/ga-tracking-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }

# # __generated__ by Terraform from "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourcegroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/securityPolicies/b20fbf86-dcfa-450f-a33f-ef71ffea60c1"
# resource "azurerm_cdn_frontdoor_security_policy" "sp_b20fbf86_dcfa_450f_a33f_ef71ffea60c1" {
#   cdn_frontdoor_profile_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev"
#   name                     = "b20fbf86-dcfa-450f-a33f-ef71ffea60c1"
#   security_policies {
#     firewall {
#       cdn_frontdoor_firewall_policy_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/frontDoorWebApplicationFirewallPolicies/waftradeDirectDev"
#       association {
#         patterns_to_match = ["/*"]
#         domain {
#           cdn_frontdoor_domain_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Cdn/profiles/afd-wwe-dev/customDomains/tradedirect-yellow-wweconomy-ups-com"
#         }
#       }
#     }
#   }
# }



