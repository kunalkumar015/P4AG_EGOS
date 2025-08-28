# resource "azurerm_web_application_firewall_policy" "waf_dashboard" {
#   name                = "waf-wwe-ga-dashboard-dev-eastus2"
#   resource_group_name = var.resource_group_name
#   location            = var.location

#   policy_settings {
#     enabled                     = true
#     mode                        = "Prevention" # Or "Detection" for testing
#     request_body_check          = true
#     file_upload_limit_in_mb     = 100
#     max_request_body_size_in_kb = 128
#   }

#   managed_rules {
#     managed_rule_set {
#       type    = "OWASP"
#       version = "3.2"
#     }
#   }

#   tags = {
#     environment = var.environment
#     project     = "wwe-ga-dashboard"
#   }
# }

# resource "azurerm_web_application_firewall_policy" "waf_webservices" {
#   name                = "waf-wwe-ga-webservices-dev-eastus2"
#   resource_group_name = var.resource_group_name
#   location            = var.location

#   policy_settings {
#     enabled                     = true
#     mode                        = "Prevention"
#     request_body_check          = true
#     file_upload_limit_in_mb     = 100
#     max_request_body_size_in_kb = 128
#   }

#   managed_rules {
#     managed_rule_set {
#       type    = "OWASP"
#       version = "3.2"
#     }
#   }

#   tags = {
#     environment = var.environment
#     project     = "wwe-ga-webservices"
#   }
# }





# # module "waf_ga_dashboard_dev" {
# #   source                   = "../modules/waf"
# #   name                     = "waf-ga-dashboard-dev-eastus2"
# #   location                 = var.region
# #   region                   = var.region
# #   app_type                 = var.app_type
# #   organization_suffix      = var.organization_suffix
# #   environment              = var.environment
# #   resource_group_name = var.resource_group_name
# #   tags                = { environment = "dev" }

# #   custom_rules        = local.dashboard_custom_rules
# #   policy_settings     = local.policy_settings
# #   managed_rules       = local.managed_rules

# #   application_gateway_ids = [
# #     "/subscriptions/${var.subscription_id}/resourceGroups/rg-wwe-ga-dev/providers/Microsoft.Network/applicationGateways/agw-wwe-ga-dashboard-dev-eastus2"
# #   ]
# # }

# # module "waf_ga_webservices_dev" {
# #   source              = "../modules/waf"
# #   name                = "waf-ga-webservices-dev-eastus2"
# #   location            = var.region
# #   resource_group_name = var.resource_group_name
# #   tags                = { environment = "dev" }
# #   region                   = var.region
# #   environment              = var.environment
# #   app_type                 = var.app_type
# #   organization_suffix      = var.organization_suffix

# #   custom_rules        = local.webservices_custom_rules
# #   policy_settings     = local.policy_settings
# #   managed_rules       = local.managed_rules

# #   application_gateway_ids = [
# #     "/subscriptions/${var.subscription_id}/resourceGroups/rg-wwe-ga-dev/providers/Microsoft.Network/applicationGateways/agw-wwe-ga-webservices-dev-eastus2"
# #   ]
# # }

