# module "sql_database" {
#   source   = "../modules/databases"
#   #max_size_gb              = "LRS"
#   sku_name                 = "S0"
#   zone_redundant           = false
#   environment              = local.environment_sanitized
#   organization_suffix      = "wwe"
#   app_type                 = local.app_type
#   region                   = local.region_sanitized

# #   public_network_access_enabled = false
# }


