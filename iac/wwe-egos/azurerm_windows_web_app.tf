module "windows_web_app_dashboard" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "dashboard"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id = azurerm_subnet.webapps.id
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]
}

module "windows_web_app_webservices" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "webservices"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id = azurerm_subnet.webapps.id
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]

}

module "windows_web_app_tradedirect" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "tradedirect"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id = azurerm_subnet.webapps.id
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]

}

module "windows_web_app_opstrackingwebapi" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "opstrackingwebapi"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id = azurerm_subnet.webapps.id
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]

}

module "windows_web_app_dao" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "dao"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id = azurerm_subnet.webapps.id
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]

}

module "windows_web_app_egosapi" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "egosapi"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id = azurerm_subnet.webapps.id
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]

}

module "windows_web_app_hangfire" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "hangfire"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id = azurerm_subnet.webapps.id
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]

}

module "windows_web_app_nuget" {
 source = "../modules/app-services"
  environment         = local.environment_sanitized
  organization_suffix = "wwe"
  app_name            = "nuget"
  app_type            = local.app_type
  app_sku             = var.app_sku
  region              = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id = azurerm_subnet.webapps.id
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]

}

module "windows_web_app_tracking_api" {
  source                     = "../modules/app-services"
  environment                = local.environment_sanitized
  organization_suffix        = "wwe"
  app_name                   = "egos-tracking-api"
  app_type                   = local.app_type
  app_sku                    = var.app_sku
  region                     = local.region_sanitized
  asp_zone_balancing_enabled = var.asp_zone_balancing_enabled
  subnet_id                  = azurerm_subnet.webapps.id
  resource_group_name        = var.resource_group_name

  depends_on = [azurerm_subnet.webapps]
}
