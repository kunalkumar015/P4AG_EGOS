
module "storage_accounts" {
  source   = "../modules/storage_account"
  #for_each = var.storage_accounts
  storage_account_name     = "sawweegos${local.environment_sanitized}${local.region_sanitized}"
  account_replication_type = var.account_replication_type
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  environment              = local.environment_sanitized
  organization_suffix      = "wwe"
  app_type                 = local.app_type
  region                   = local.region_sanitized
}

output "storage_accounts" {
  value     = module.storage_accounts
  sensitive = true
}


