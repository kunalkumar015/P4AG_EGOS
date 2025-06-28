
data "azurerm_key_vault" "egos_kv" {
  name                = "kv2-wwe-dev-eastus2"         
  resource_group_name = "rg-wwe-dev"          
}

data "azurerm_key_vault_certificate" "custom_cert" {
  name         = "egosapp-dev-cert"            
  key_vault_id = data.azurerm_key_vault.egos_kv.id
}

resource "azurerm_cdn_frontdoor_secret" "afdSecret" {
  name                       = "egosapp-dev-secret"
  cdn_frontdoor_profile_id  = azurerm_cdn_frontdoor_profile.afdProfile.id

  secret {
    customer_certificate {
      key_vault_certificate_id = data.azurerm_key_vault_certificate.custom_cert.id
    }
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "afdSecrets" {
  name                      = var.custom_domain_name           
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afdProfile.id
  host_name                 = var.custom_domain_hostname      

  tls {
    certificate_type = "CustomerCertificate"
    cdn_frontdoor_secret_id  = azurerm_cdn_frontdoor_secret.afdSecret.id
  }
}



# https://kv2-wwe-dev-eastus2.vault.azure.net/secrets/egosapp-dev-cert/922f31e33cdb481c9e5deae730493ec8