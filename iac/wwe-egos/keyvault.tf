module "keyvault" {
  source                   = "../modules/keyvault"
  environment              = local.environment_sanitized
  organization_suffix      = "wwe"
  app_type                 = local.app_type
  region                   = local.region_sanitized
  tenant_id                = var.tenant_id
  private_endpoint_subnet_id = var.subnet_id
}