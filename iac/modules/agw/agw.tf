resource "azurerm_public_ip" "agw_pip" {
  name                = "agw-public-ip-eastus2"
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method   = "Static"              # or "Dynamic"
  sku                 = "Standard"            # "Basic" is deprecated for many services

  zones               = ["1", "2", "3"]        # Optional: for zone-redundant IP
}



resource "azurerm_web_application_firewall_policy" "agwwaf" {
  name                = "agw-wafpolicy-dev-eastus2"
  resource_group_name = var.resource_group_name
  location            = var.location

  policy_settings {
    enabled = true
    mode    = "Prevention"  # or "Detection"
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}

resource "azurerm_application_gateway" "agw" {
  name                              = var.agw_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  enable_http2                      = true
  fips_enabled                      = false
  zones                             = ["1", "2", "3"]
  firewall_policy_id                = azurerm_web_application_firewall_policy.agwwaf.id
  force_firewall_policy_association = false

  tags = {
    environment = var.environment
  }

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
    subnet_id = var.agw_subnet_id
  }

  frontend_ip_configuration {
  name                          = "appGwPublicFrontendIpIPv4"
  public_ip_address_id          = azurerm_public_ip.agw_pip.id
  private_ip_address_allocation = "Dynamic" # or remove this line
}

frontend_ip_configuration {
  name                          = "appGwPrivateFrontendIp"
  subnet_id                     = var.agw_subnet_id
  private_ip_address_allocation = "Static"
  private_ip_address            = "172.22.34.178" 
}

  frontend_port {
    name = "port_443"
    port = 443
  }

  backend_address_pool {
    name         = "bp-ga-webservices-eastus2"
    fqdns        = [var.backend_fqdn]
    ip_addresses = []
  }

  backend_http_settings {
    name                                = "bs-ga-webservices"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 20
    cookie_based_affinity               = "Disabled"
    affinity_cookie_name                = "ApplicationGatewayAffinity"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = "listener-ga-webservices-dev"
    frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
    frontend_port_name             = "port_443"
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_certificate_name
    require_sni                    = false
  }

  request_routing_rule {
    name                        = "rt-ga-webservices"
    rule_type                   = "Basic"
    priority                    = 1
    http_listener_name          = "listener-ga-webservices-dev"
    backend_address_pool_name   = "bp-ga-webservices-eastus2"
    backend_http_settings_name  = "bs-ga-webservices"
  }

ssl_certificate {
  name                = var.ssl_certificate_name
  key_vault_secret_id = data.azurerm_key_vault_secret.cert.id
}
# Sensitive value must be handled via a separate file or Key Vault ref
}
