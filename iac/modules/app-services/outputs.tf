# output "vault" {
#   value = azurerm_recovery_services_vault.vault
# }
# output "daily_vm_backup_policy" {
#   value = azurerm_backup_policy_vm.daily
# }
# output "daily_fileshare_backup_policy" {
#   value = azurerm_backup_policy_file_share.daily
# }

output "log_analytics_workspace_id" {
  value = data.azurerm_log_analytics_workspace.logs.workspace_id
}
output "instrumentation_key" {
  value = azurerm_application_insights.app-in.instrumentation_key
}