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
  subnet_id                     = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/virtualNetworks/vnet-wwe-egos-dev-eastus2/subnets/webapps-subnet"
  resource_group_name           = var.resource_group_name
  identity_ids                  = var.identity_ids
  ssl_certificate_name          = var.ssl_certificate_name
  backend_fqdn                  = var.backend_fqdn
  app_type                      = var.app_type
  organization_suffix           = var.organization_suffix
  tenant_id                     = var.tenant_id
  key_vault_name                = var.key_vault_name
  key_vault_rg                  = var.key_vault_rg
  snet_agw_id                 = var.snet_agw_id

depends_on = [
    azurerm_subnet.agw_subnet
  ]
}


