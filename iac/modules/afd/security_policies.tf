resource "azurerm_cdn_frontdoor_firewall_policy" "afdFirewall_policy" {
  name                = "webAppsDevWaf"
  resource_group_name = "rg-wwe-dev"
  sku_name = "Standard_AzureFrontDoor"
  mode                = "Prevention"
  enabled             = true

  tags = {
    app         = "webapp"
    environment = "dev"
    subproject  = "egos-dev"
  }

  # Legacy IP-based rule (preserved)
  custom_rule {
    name                           = "IPAllowNetsparker"
    priority                       = 10
    action                         = "Allow"
    rate_limit_duration_in_minutes = 1
    rate_limit_threshold           = 100
    enabled                        = true
    type                           = "MatchRule"

    match_condition {
      match_variable     = "RemoteAddr"
      operator           = "IPMatch"
      match_values       = [
        "153.2.246.0/24",
        "153.2.247.0/24",
        "34.237.50.127",
        "54.85.169.114",
        "54.88.149.100"
      ]
      negation_condition = false
      selector           = null
      transforms         = []
    }
  }

  # Microsoft managed rule sets with action explicitly defined
  managed_rule {
    type    = "Microsoft_DefaultRuleSet"
    version = "1.1"
    action  = "Block"
  }

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
    action  = "Block"
  }
}




# # # resource "azurerm_frontdoor_firewall_policy" "afdFirewall_policy" {
# # #   for_each = var.afd_security_policies

# # #   name                = each.key
# # #   resource_group_name = var.resource_group
# # #   custom_block_response_status_code = 403

# # #   # Example WAF policy details; customize as needed
# # #   managed_rules {
# # #     managed_rule_set {
# # #       rule_set_type    = "OWASP"
# # #       rule_set_version = "3.2"
# # #     }
# # #   }

# # #   enabled = each.value.waf_enabled
# # # }

# # resource "azurerm_web_application_firewall_policy" "this" {
# #   name                = each.key
# #   resource_group_name = var.resource_group
# #   location            = var.location
# #   policy_settings {
# #     enabled                     = each.value.waf_enabled
# #     mode                        = "Prevention"
# #     request_body_check          = true
# #     file_upload_limit_in_mb     = 100
# #     max_request_body_size_in_kb = 128
# #   }

# #   managed_rules {
# #     managed_rule_set {
# #       type    = "OWASP"
# #       version = "3.2"
# #     }
# #   }
# # }


# # resource "azurerm_cdn_frontdoor_security_policy" "afdSecurity_policies" {
# #   name                     = var.security_policy_name
# #   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afdProfile.id

# #   security_policies {
# #     firewall {
# #       waf_policy {
# #         cdn_frontdoor_firewall_policy_id = var.firewall_policy_id

# #         association {
# #           domain_id        = azurerm_cdn_frontdoor_endpoint.this.id
# #           pattern_to_match = "/*"
# #         }
# #       }
# #     }
# #   }
# # }

# # __generated__ by Terraform
# # Please review these resources and move them into your main configuration files.

# # __generated__ by Terraform
# resource "azurerm_cdn_frontdoor_firewall_policy" "afdFirewall_policy" {
#   custom_block_response_body        = null
#   custom_block_response_status_code = 403
#   enabled                           = true
#   mode                              = "Prevention"
#   name                              = "webAppsDevWaf"
#   redirect_url                      = null
#   request_body_check_enabled        = false
#   resource_group_name               = "rg-wwe-dev"
#   sku_name                          = "Classic_AzureFrontDoor"
#   tags = {
#     app         = "webapp"
#     environment = "dev"
#     subproject  = "egos-dev"
#   }
#   custom_rule {
#     action                         = "Allow"
#     enabled                        = true
#     name                           = "Extjs"
#     priority                       = 100
#     rate_limit_duration_in_minutes = 1
#     rate_limit_threshold           = 100
#     type                           = "MatchRule"
#     match_condition {
#       match_values       = ["_dc="]
#       match_variable     = "RequestUri"
#       negation_condition = false
#       operator           = "Contains"
#       selector           = null
#       transforms         = []
#     }
#   }
#   custom_rule {
#     action                         = "Allow"
#     enabled                        = true
#     name                           = "Receiving"
#     priority                       = 200
#     rate_limit_duration_in_minutes = 1
#     rate_limit_threshold           = 100
#     type                           = "MatchRule"
#     match_condition {
#       match_values       = ["Warehouse/Receive"]
#       match_variable     = "RequestUri"
#       negation_condition = false
#       operator           = "Contains"
#       selector           = null
#       transforms         = []
#     }
#   }
#   custom_rule {
#     action                         = "Allow"
#     enabled                        = true
#     name                           = "DownloadInvoiceList"
#     priority                       = 300
#     rate_limit_duration_in_minutes = 1
#     rate_limit_threshold           = 100
#     type                           = "MatchRule"
#     match_condition {
#       match_values       = ["vendorinvoicing/data/DownloadInvoiceList"]
#       match_variable     = "RequestUri"
#       negation_condition = false
#       operator           = "Contains"
#       selector           = null
#       transforms         = []
#     }
#   }
#   custom_rule {
#     action                         = "Allow"
#     enabled                        = false
#     name                           = "LtpaTokenCookies"
#     priority                       = 400
#     rate_limit_duration_in_minutes = 1
#     rate_limit_threshold           = 100
#     type                           = "MatchRule"
#     match_condition {
#       match_values       = ["\"\""]
#       match_variable     = "Cookies"
#       negation_condition = false
#       operator           = "Equal"
#       selector           = "LtpaToken"
#       transforms         = ["UrlDecode"]
#     }
#   }
#   custom_rule {
#     action                         = "Allow"
#     enabled                        = true
#     name                           = "IPAllowNetsparker"
#     priority                       = 10
#     rate_limit_duration_in_minutes = 1
#     rate_limit_threshold           = 100
#     type                           = "MatchRule"
#     match_condition {
#       match_values       = ["153.2.246.0/24", "153.2.247.0/24", "34.237.50.127", "54.85.169.114", "54.88.149.100"]
#       match_variable     = "RemoteAddr"
#       negation_condition = false
#       operator           = "IPMatch"
#       selector           = null
#       transforms         = []
#     }
#   }
#   custom_rule {
#     action                         = "Allow"
#     enabled                        = true
#     name                           = "SignalR"
#     priority                       = 500
#     rate_limit_duration_in_minutes = 1
#     rate_limit_threshold           = 100
#     type                           = "MatchRule"
#     match_condition {
#       match_values       = ["signalr/negotiate"]
#       match_variable     = "RequestUri"
#       negation_condition = false
#       operator           = "Contains"
#       selector           = null
#       transforms         = []
#     }
#   }
#   managed_rule {
#     action  = ""
#     type    = "Microsoft_DefaultRuleSet"
#     version = "1.1"
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "s_ev36"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "abck"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "ak_bmsc"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "bm_sv"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "bm_sz"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "com.ups.ims.lasso.sDataLassoFeb19"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "LtpaToken"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "NBS-XSRF-TOKEN"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "ReturnsUserOptions"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "SCS-XSRF-TOKEN"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "session_ups_com"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "utag"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "wfx_unq"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "X-CSRF-Token"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "X-XSRF-TOKEN"
#     }
#     exclusion {
#       match_variable = "RequestCookieNames"
#       operator       = "Equals"
#       selector       = "bm_s"
#     }
#     override {
#       rule_group_name = "SQLI"
#       rule {
#         action  = "Block"
#         enabled = true
#         rule_id = "942230"
#       }
#       rule {
#         action  = "Block"
#         enabled = true
#         rule_id = "942340"
#         exclusion {
#           match_variable = "RequestCookieNames"
#           operator       = "Equals"
#           selector       = "LtpaToken"
#         }
#       }
#       rule {
#         action  = "Block"
#         enabled = true
#         rule_id = "942330"
#         exclusion {
#           match_variable = "RequestCookieNames"
#           operator       = "Equals"
#           selector       = "LtpaToken"
#         }
#       }
#       rule {
#         action  = "Block"
#         enabled = true
#         rule_id = "942450"
#       }
#     }
#     override {
#       rule_group_name = "LFI"
#       rule {
#         action  = "Block"
#         enabled = true
#         rule_id = "930130"
#         exclusion {
#           match_variable = "RequestCookieNames"
#           operator       = "Equals"
#           selector       = "LtpaToken"
#         }
#       }
#     }
#   }
#   managed_rule {
#     action  = ""
#     type    = "Microsoft_BotManagerRuleSet"
#     version = "1.0"
#   }
# }
