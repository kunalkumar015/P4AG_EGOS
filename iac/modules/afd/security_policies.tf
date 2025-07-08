resource "azurerm_cdn_frontdoor_firewall_policy" "afdFirewall_policy" {
  name                = "webAppsDevWaf"
  resource_group_name = "rg-wwe-dev"
  sku_name = "Premium_AzureFrontDoor"
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
        # figure out whether the same ip address sources should be allowed to contact the front door in field compared to the brownfield or do we need to white list different set of public IP addresses
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


