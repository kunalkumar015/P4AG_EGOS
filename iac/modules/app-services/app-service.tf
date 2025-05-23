resource "azurerm_service_plan" "app_plan" {
  name                   = "asp-wwe-${local.app_type}-${var.app_name}-${local.environment_sanitized}-${local.region_sanitized}"
  location               = data.azurerm_resource_group.resource_group.location
  resource_group_name    = data.azurerm_resource_group.resource_group.name
  os_type                = "Windows"
  sku_name               = var.app_sku
  zone_balancing_enabled = var.asp_zone_balancing_enabled
  #worker_count           = "3"
}

resource "azurerm_windows_web_app" "windows_app" {
  name                = "ase2-wwe-${local.app_type}-${var.app_name}-${local.environment_sanitized}-${local.region_sanitized}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    always_on           = true
    minimum_tls_version = 1.2
    
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }
    
    ip_restriction {
        name = "AllowFrontdoor"
        priority = 10
        action = "Allow"
        service_tag = "AzureFrontDoor.Backend"
        headers = []
      }
    ip_restriction_default_action = "Deny"
    vnet_route_all_enabled        = "true"
  }

  identity {
    type                     = "UserAssigned"
    identity_ids             = [data.azurerm_user_assigned_identity.mi_user.id]
  }

  # app_settings = {
  #   APPINSIGHTS_INSTRUMENTATIONKEY = "${azurerm_application_insights.app-in.instrumentation_key}"

  # }
  
lifecycle {
    ignore_changes = [
        app_settings,
        sticky_settings,
        site_config
    ]
}

virtual_network_subnet_id = var.subnet_id
}

resource "azurerm_windows_web_app_slot" "windows_slot" {
  name           = "staging"
  app_service_id = azurerm_windows_web_app.windows_app.id

  site_config {
    always_on           = true
    minimum_tls_version = 1.2
  }

  # app_settings = {
  #   APPINSIGHTS_INSTRUMENTATIONKEY = "${azurerm_application_insights.app-in.instrumentation_key}"
  # }

lifecycle {
    ignore_changes = [
        app_settings,
        site_config
    ]
  }

}


# resource "azurerm_application_insights" "app-in" {
#   name                = "appi-wwe-${local.app_type}-${var.app_name}-${local.environment_sanitized}-${local.region_sanitized}"
#   location            = data.azurerm_resource_group.resource_group.location
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   workspace_id        = data.azurerm_log_analytics_workspace.logs.id
#   application_type    = "web"
# }


