


# -------------------- DATA ----------------------

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}

data "azurerm_key_vault_secret" "cert" {
  name         = var.ssl_certificate_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

# -------------------- PUBLIC IPs ----------------------

resource "azurerm_public_ip" "pip_dashboard" {
  name                = "agw-public-ip-ga-dashboard-dev-eastus2"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_public_ip" "pip_webservices" {
  name                = "agw-public-ip-ga-webservices-dev-eastus2"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

# -------------------- WAF Policies ----------------------

resource "azurerm_web_application_firewall_policy" "waf_dashboard" {
  name                = "agw-wafpolicy-dashboard-dev-eastus2"
  resource_group_name = var.resource_group_name
  location            = var.location

  policy_settings {
    enabled = true
    mode    = "Prevention"
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}

resource "azurerm_web_application_firewall_policy" "waf_webservices" {
  name                = "agw-wafpolicy-webservices-dev-eastus2"
  resource_group_name = var.resource_group_name
  location            = var.location

  policy_settings {
    enabled = true
    mode    = "Prevention"
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}

# -------------------- AGW: Dashboard ----------------------

resource "azurerm_application_gateway" "agw_dashboard" {
  name                              = "agw-wwe-ga-dashboard-dev-eastus2"
  location                          = var.location
  resource_group_name               = var.resource_group_name
  enable_http2                      = true
  zones                             = ["1"]
  firewall_policy_id                = azurerm_web_application_firewall_policy.waf_dashboard.id

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 0
  }

  autoscale_configuration {
    min_capacity = 0
    max_capacity = 10
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.snet_agw_id
  }

  frontend_ip_configuration {
    name                 = "appGwPublicFrontendIpIPv4"
    public_ip_address_id = azurerm_public_ip.pip_dashboard.id
  }

  frontend_port {
    name = "port_443"
    port = 443
  }

  backend_address_pool {
    name         = "bp-ga-dashboard-eastus2"
    fqdns        = [var.backend_fqdn_dashboard]
  }

  backend_http_settings {
    name                                = "bs-ga-dashboard"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 20
    cookie_based_affinity               = "Disabled"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "listener-ga-dashboard-dev"
    frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
    frontend_port_name             = "port_443"
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_certificate_name
  }

  request_routing_rule {
    name                       = "rt-ga-dashboard"
    rule_type                  = "Basic"
    priority                   = 1
    http_listener_name         = "listener-ga-dashboard-dev"
    backend_address_pool_name  = "bp-ga-dashboard-eastus2"
    backend_http_settings_name = "bs-ga-dashboard"
  }

  ssl_certificate {
    name                = var.ssl_certificate_name
    key_vault_secret_id = data.azurerm_key_vault_secret.cert.id
  }
}

# -------------------- AGW: Webservices ----------------------

resource "azurerm_application_gateway" "agw_webservices" {
  name                              = "agw-wwe-ga-webservices-dev-eastus2"
  location                          = var.location
  resource_group_name               = var.resource_group_name
  enable_http2                      = true
  zones                             = ["1"]
  firewall_policy_id                = azurerm_web_application_firewall_policy.waf_webservices.id

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 0
  }

  autoscale_configuration {
    min_capacity = 0
    max_capacity = 10
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.snet_agw_id
  }

  frontend_ip_configuration {
    name                 = "appGwPublicFrontendIpIPv4"
    public_ip_address_id = azurerm_public_ip.pip_webservices.id
  }

  frontend_port {
    name = "port_443"
    port = 443
  }

  backend_address_pool {
    name         = "bp-ga-webservices-eastus2"
    fqdns        = [var.backend_fqdn_webservices]
  }

  backend_http_settings {
    name                                = "bs-ga-webservices"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 20
    cookie_based_affinity               = "Disabled"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "listener-ga-webservices-dev"
    frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
    frontend_port_name             = "port_443"
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_certificate_name
  }

  request_routing_rule {
    name                       = "rt-ga-webservices"
    rule_type                  = "Basic"
    priority                   = 1
    http_listener_name         = "listener-ga-webservices-dev"
    backend_address_pool_name  = "bp-ga-webservices-eastus2"
    backend_http_settings_name = "bs-ga-webservices"
  }

  ssl_certificate {
    name                = var.ssl_certificate_name
    key_vault_secret_id = data.azurerm_key_vault_secret.cert.id
  }
}
















# # module "agw" {
# #   source   = "../modules/agw"
# #   environment              = local.environment_sanitized
# #   organization_suffix      = "wwe"
# #   app_type                 = local.app_type
# #   region                   = local.region_sanitized
# #   tenant_id                = var.tenant_id
# # }


# module "agw_ga_dashboard" {
#   source = "../modules/agw"

  
#   location                      = var.location
#   region                        = var.region
#   environment                   = var.environment
#   agw_name                      = "agw-wwe-ga-dashboard-dev-eastus2"
#   subnet_id                     = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/virtualNetworks/vnet-wwe-ga-dev-eastus2/subnets/snet_agw"
#   resource_group_name           = var.resource_group_name
#   identity_ids                  = var.identity_ids
#   ssl_certificate_name          = var.ssl_certificate_name
#   backend_fqdn                  = var.backend_fqdn
#   app_type                      = var.app_type
#   organization_suffix           = var.organization_suffix
#   tenant_id                     = var.tenant_id
#   key_vault_name                = var.key_vault_name
#   key_vault_rg                  = var.key_vault_rg
#   snet_agw_id                   = var.snet_agw_id
#   sku_name                      = var.app_sku

# depends_on = [
#     azurerm_subnet.agw_subnet
#   ]
# }


# module "agw_ga_webservices" {
#   source = "../modules/agw"
#   location                      = var.location
#   region                        = var.region
#   environment                   = var.environment
#   agw_name                      = "agw-wwe-ga-webservices-dev-eastus2"
#   subnet_id                     = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/virtualNetworks/vnet-wwe-ga-dev-eastus2/subnets/snet_agw"
#   resource_group_name           = var.resource_group_name
#   identity_ids                  = var.identity_ids
#   ssl_certificate_name          = var.ssl_certificate_name
#   backend_fqdn                  = var.backend_fqdn
#   app_type                      = var.app_type
#   organization_suffix           = var.organization_suffix
#   tenant_id                     = var.tenant_id
#   key_vault_name                = var.key_vault_name
#   key_vault_rg                  = var.key_vault_rg
#   snet_agw_id                   = var.snet_agw_id
#   sku_name                      = var.app_sku

# depends_on = [
#     azurerm_subnet.agw_subnet
#   ]
# }