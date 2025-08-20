# module "waf_ga_dashboard_dev" {
#   source                   = "../modules/waf"
#   name                     = "waf-ga-dashboard-dev-eastus2"
#   location                 = var.region
#   region                   = var.region
#   app_type                 = var.app_type
#   organization_suffix      = var.organization_suffix
#   environment              = var.environment
#   resource_group_name = var.resource_group_name
#   tags                = { environment = "dev" }

#   custom_rules        = local.dashboard_custom_rules
#   policy_settings     = local.policy_settings
#   managed_rules       = local.managed_rules

#   application_gateway_ids = [
#     "/subscriptions/${var.subscription_id}/resourceGroups/rg-wwe-ga-dev/providers/Microsoft.Network/applicationGateways/agw-wwe-ga-dashboard-dev-eastus2"
#   ]
# }

# module "waf_ga_webservices_dev" {
#   source              = "../modules/waf"
#   name                = "waf-ga-webservices-dev-eastus2"
#   location            = var.region
#   resource_group_name = var.resource_group_name
#   tags                = { environment = "dev" }
#   region                   = var.region
#   environment              = var.environment
#   app_type                 = var.app_type
#   organization_suffix      = var.organization_suffix

#   custom_rules        = local.dashboard_custom_rules
#   policy_settings     = local.policy_settings
#   managed_rules       = local.managed_rules

#   application_gateway_ids = [
#     "/subscriptions/${var.subscription_id}/resourceGroups/rg-wwe-ga-dev/providers/Microsoft.Network/applicationGateways/agw-wwe-ga-webservices-dev-eastus2"
#   ]
# }

