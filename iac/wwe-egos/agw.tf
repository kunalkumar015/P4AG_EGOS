# module "agw" {
#   source   = "../modules/agw"
#   environment              = local.environment_sanitized
#   organization_suffix      = "wwe"
#   app_type                 = local.app_type
#   region                   = local.region_sanitized
#   tenant_id                = var.tenant_id
# }


module "agw" {
  source = "../modules/agw"

  location                      = var.location
  environment                   = var.environment
  agw_name                      = var.agw_name
  resource_group_name           = var.resource_group_name
  firewall_policy_id            = var.firewall_policy_id
  public_ip_address_id          = var.public_ip_address_id
  subnet_id                     = var.subnet_id
  identity_ids                  = var.identity_ids
  ssl_certificate_name          = var.ssl_certificate_name
  backend_fqdn                  = var.backend_fqdn
  ssl_certificate_data          = var.ssl_certificate_data
  ssl_certificate_password      = var.ssl_certificate_password

}


