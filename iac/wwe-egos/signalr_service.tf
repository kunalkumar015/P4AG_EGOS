module "signalr_service" {
  source   = "../modules/signalr"
  sku                            = "Standard_S1"
  public_network_access_enabled  = false
  environment                    = local.environment_sanitized
  organization_suffix            = "wwe"
  app_type                       = local.app_type
  region                         = local.region_sanitized
}