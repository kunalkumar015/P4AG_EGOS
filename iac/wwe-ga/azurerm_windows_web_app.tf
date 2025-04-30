#delete 1124 recreate 0125

module "windows_web_app_dashboard" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "dashboard"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
}



# module "windows_web_app_webservices" {
#  source = "../modules/app-services"
#   environment         = local.environment_sanitized
#   organization_suffix = "wwe"
#   app_name            = "webservices"
#   app_type            = local.app_type
#   app_sku             = var.app_sku
#   region              = local.region_sanitized
#   asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
# }

# module "windows_web_app_globalcheckout" {
#  source = "../modules/app-services"
#   environment         = local.environment_sanitized
#   organization_suffix = "wwe"
#   app_name            = "globalcheckout"
#   app_type            = local.app_type
#   app_sku             = var.app_sku
#   region              = local.region_sanitized
#   asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
# }

# module "windows_web_app_shopifyintegrationws" {
#  source = "../modules/app-services"
#   environment         = "prd"
#   organization_suffix = "wwe"
#   app_name            = "shopifyintegrationws"
#   app_type            = local.app_type
#   app_sku             = "P2v2"
#   region              = local.region_sanitized
# }

# module "windows_web_app_tracking" {
#  source = "../modules/app-services"
#   environment         = "prd"
#   organization_suffix = "wwe"
#   app_name            = "tracking"
#   app_type            = local.app_type
#   app_sku             = "P2v2"
#   region              = local.region_sanitized
# }

# module "windows_web_app_carthandoff" {
#  source = "../modules/app-services"
#   environment         = "prd"
#   organization_suffix = "wwe"
#   app_name            = "carthandoff"
#   app_type            = local.app_type
#   app_sku             = "P2v2"
#   region              = local.region_sanitized
# }

# module "windows_web_app_hangfire" {
#  source = "../modules/app-services"
#   environment         = "prd"
#   organization_suffix = "wwe"
#   app_name            = "hangfire"
#   app_type            = local.app_type
#   app_sku             = "P2v2"
#   region              = local.region_sanitized
# }

# module "windows_web_app_classifying" {
#  source = "../modules/app-services"
#   environment         = "prd"
#   organization_suffix = "wwe"
#   app_name            = "classifying"
#   app_type            = local.app_type
#   app_sku             = "P2v2"
#   region              = local.region_sanitized
# }
# module "windows_web_app_webjobs" {
#  source = "../modules/app-services"
#   environment         = "prd"
#   organization_suffix = "wwe"
#   app_name            = "webjobs"
#   app_type            = local.app_type
#   app_sku             = "P2v2"
#   region              = local.region_sanitized
# }