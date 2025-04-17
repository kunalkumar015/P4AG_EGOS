# resource "azurerm_resource_group" "regional_backup_vault" {
#   name     = "rg-backup-${local.region_sanitized}"
#   location = local.region_sanitized
# }