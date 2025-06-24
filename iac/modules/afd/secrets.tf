resource "azurerm_cdn_frontdoor_custom_domain" "afdSecrets" {
  name                       = var.custom_domain_name
  cdn_frontdoor_profile_id  = azurerm_cdn_frontdoor_profile.afdProfile.id
  host_name                  = var.custom_domain_hostname

  tls {
    certificate_type = "CustomerCertificate"

    # customer_certificate {
    #   secret_id = azurerm_cdn_frontdoor_secret.afdSecrets.id
    # }
  }
}

