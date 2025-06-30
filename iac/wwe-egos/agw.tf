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
  region                        = var.region
  environment                   = var.environment
  agw_name                      = var.agw_name
  subnet_id                     = "/subscriptions/4adfceca-1634-4dcf-96f9-a0c93bfae4ea/resourceGroups/rg-wwe-ga-dev/providers/Microsoft.Network/virtualNetworks/vnet-wwe-ga-dev-eastus2/subnets/sn-appgw-webservices"
  resource_group_name           = var.resource_group_name
  firewall_policy_id            = var.firewall_policy_id
  public_ip_address_id          = var.public_ip_address_id
  identity_ids                  = var.identity_ids
  ssl_certificate_name          = var.ssl_certificate_name
  backend_fqdn                  = var.backend_fqdn
  app_type                      = var.app_type
  organization_suffix           = var.organization_suffix
  tenant_id                     = var.tenant_id
}


