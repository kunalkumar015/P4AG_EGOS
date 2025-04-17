# resource "azurerm_recovery_services_vault" "vault" {
#   name                = "vault-es-${local.subscription_name_sanitized}-${local.region_sanitized}"
#   location            = azurerm_resource_group.regional_backup_vault.location
#   resource_group_name = azurerm_resource_group.regional_backup_vault.name
#   sku                 = "Standard"

#   soft_delete_enabled = true

#   identity {
#     type = "SystemAssigned"
#   }
# }

# resource "azurerm_backup_policy_vm" "daily" {
#   name                = "daily-vm-backup-policy"
#   resource_group_name = azurerm_recovery_services_vault.vault.resource_group_name
#   recovery_vault_name = azurerm_recovery_services_vault.vault.name

#   timezone                       = "UTC"
#   instant_restore_retention_days = 5
#   backup {
#     frequency = "Daily"
#     time      = "23:00"
#   }

#   retention_daily {
#     count = 10
#   }

#   retention_weekly {
#     count    = 42
#     weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
#   }

#   retention_monthly {
#     count    = 7
#     weekdays = ["Sunday", "Wednesday"]
#     weeks    = ["First", "Last"]
#   }

#   retention_yearly {
#     count    = 50
#     weekdays = ["Sunday"]
#     weeks    = ["Last"]
#     months   = ["January"]
#   }
# }

# resource "azurerm_backup_policy_file_share" "daily" {
#   name                = "daily-fileshare-backup-policy"
#   resource_group_name = azurerm_recovery_services_vault.vault.resource_group_name
#   recovery_vault_name = azurerm_recovery_services_vault.vault.name

#   timezone = "UTC"

#   backup {
#     frequency = "Daily"
#     time      = "23:00"
#   }

#   retention_daily {
#     count = 10
#   }

#   retention_weekly {
#     count    = 7
#     weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
#   }

#   retention_monthly {
#     count    = 7
#     weekdays = ["Sunday", "Wednesday"]
#     weeks    = ["First", "Last"]
#   }

#   retention_yearly {
#     count    = 10
#     weekdays = ["Sunday"]
#     weeks    = ["Last"]
#     months   = ["January"]
#   }
# }

# resource "azurerm_role_assignment" "vault_subnet_rg_contributor" {
#   scope                = data.azurerm_resource_group.subnet_resource_group.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_recovery_services_vault.vault.identity[0].principal_id
# }

# resource "azurerm_role_assignment" "vault_rg_contributor" {
#   scope                = azurerm_resource_group.regional_backup_vault.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_recovery_services_vault.vault.identity[0].principal_id
# }

# resource "azurerm_private_endpoint" "vault" {
#   name                = "pe-${azurerm_recovery_services_vault.vault.name}"
#   location            = azurerm_recovery_services_vault.vault.location
#   resource_group_name = azurerm_recovery_services_vault.vault.resource_group_name
#   subnet_id           = var.subnet.id

#   private_service_connection {
#     name                           = "psc-${azurerm_recovery_services_vault.vault.name}"
#     is_manual_connection           = false
#     private_connection_resource_id = azurerm_recovery_services_vault.vault.id
#     subresource_names              = ["AzureBackup"]
#   }

#   depends_on = [
#     azurerm_role_assignment.vault_rg_contributor,
#     azurerm_role_assignment.vault_subnet_rg_contributor
#   ]
#   lifecycle {
#     ignore_changes = [
#       private_dns_zone_group
#     ]
#   }
# }