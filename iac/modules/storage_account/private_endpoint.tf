# module "private_endpoint" {
#   source   = "../networking/private_endpoint"
#   for_each = var.private_endpoints

#   resource_id         = azurerm_storage_account.stg.id
#   name                = each.value.name
#   location            = local.location
#   resource_group_name = local.resource_group_name
#   subnet_id           = can(each.value.subnet_id) || can(each.value.virtual_subnet_key) ? try(each.value.subnet_id, var.virtual_subnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.virtual_subnet_key].id) : var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
#   settings            = each.value
#   global_settings     = var.global_settings
#   tags                = local.tags
#   base_tags           = var.base_tags
#   private_dns         = var.private_dns
#   client_config       = var.client_config
# }

resource "azurerm_private_endpoint" "storage_account" {
  name                = "pep-storage-${local.environment_sanitized}-${local.region_sanitized}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-storage-${local.environment_sanitized}"
    private_connection_resource_id = azurerm_storage_account.stacc.id
    is_manual_connection           = false
    subresource_names              = ["Sql"] # Use "Sql" for Cosmos DB SQL API
  }

  depends_on = [azurerm_storage_account.stacc]
}

