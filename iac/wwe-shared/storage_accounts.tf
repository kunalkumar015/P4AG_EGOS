#delete 1124 recreate 0125
# module "storage_accounts_logs" {
#   source   = "../modules/storage_account"
#   storage_account_name     = "sawwelogsprd${local.region_sanitized}"
#   account_replication_type = "GRS"
#   account_kind             = "StorageV2"
#   account_tier             = "Standard"
#   access_tier              = "Hot"
#   environment              = "prd"
#   organization_suffix      = "wwe"
#   app_type                 = local.app_type
#   region                   = local.region_sanitized
# }

# output "storage_accounts" {
#   value     = module.storage_accounts_logs
#   sensitive = true
# }


