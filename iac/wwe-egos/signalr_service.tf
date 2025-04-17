# module "signalr_service" {
#   source   = "../modules/signalr"
#   sku                            = "Premium_P1"
#   public_network_access_enabled  = true
#   environment                    = "prd"
#   organization_suffix            = "wwe"
#   app_type                       = local.app_type
#   region                         = local.region_sanitized
# }