
locals {
  region                 = "eastus2"
  rg_name                = "rg-wwe-uat"
  vnet_name              = "vnet-wwe-egos-uat-eastus2"
  subnet_name            = "webapp-shared-subnet-uat-eastus2"
  sku_name               = "P1v2"
  environment            = "uat"
  apps = [
    "dashboard",
    "webservices",
    "tradedirect",
    "opstrackingwebapi",
    "dao",
    "egosapi",
    "hangfire",
    "nuget",
    "egos-tracking-api"
  ]
}

data "azurerm_resource_group" "uat" {
  provider = azurerm.uat
  name     = local.rg_name
}

data "azurerm_subnet" "shared" {
  provider             = azurerm.uat
  name                 = local.subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rg_name
}

# ---------------- Shared Managed Identity ----------------
resource "azurerm_user_assigned_identity" "shared_identity" {
  provider            = azurerm.uat
  name                = "mi-wwe-uat-eastus2"
  location            = local.region
  resource_group_name = local.rg_name
}

# ---------------- Loop through each app ----------------
# Terraform doesn’t support looping over resource names, so we expand each app manually.

# === APP: dashboard ===
resource "azurerm_service_plan" "dashboard" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-dashboard-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "dashboard" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-dashboard-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.dashboard.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on           = true
    minimum_tls_version = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_dashboard" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.dashboard.id
  subnet_id      = data.azurerm_subnet.shared.id
}


resource "azurerm_service_plan" "webservices" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-webservices-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "webservices" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-webservices-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.webservices.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on           = true
    minimum_tls_version = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_webservices" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.webservices.id
  subnet_id      = data.azurerm_subnet.shared.id
}


# --------tradedirect------------------------------

resource "azurerm_service_plan" "tradedirect" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-tradedirect-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "tradedirect" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-tradedirect-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.tradedirect.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on           = true
    minimum_tls_version = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_tradedirect" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.tradedirect.id
  subnet_id      = data.azurerm_subnet.shared.id
}



# -----------------opstrackingwebapi---------------


resource "azurerm_service_plan" "opstrackingwebapi" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-opstrackingwebapi-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "opstrackingwebapi" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-opstrackingwebapi-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.opstrackingwebapi.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on           = true
    minimum_tls_version = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_opstrackingwebapi" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.opstrackingwebapi.id
  subnet_id      = data.azurerm_subnet.shared.id
}


# -----------dao-------------------

resource "azurerm_service_plan" "dao" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-dao-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "dao" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-dao-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.dao.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on           = true
    minimum_tls_version = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_dao" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.dao.id
  subnet_id      = data.azurerm_subnet.shared.id
}



# === APP: egosapi ===
resource "azurerm_service_plan" "egosapi" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-egosapi-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "egosapi" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-egosapi-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.egosapi.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on              = true
    minimum_tls_version    = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_egosapi" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.egosapi.id
  subnet_id      = data.azurerm_subnet.shared.id
}

# === APP: hangfire ===
resource "azurerm_service_plan" "hangfire" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-hangfire-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "hangfire" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-hangfire-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.hangfire.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on              = true
    minimum_tls_version    = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_hangfire" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.hangfire.id
  subnet_id      = data.azurerm_subnet.shared.id
}

# === APP: nuget ===
resource "azurerm_service_plan" "nuget" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-nuget-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "nuget" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-nuget-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.nuget.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on              = true
    minimum_tls_version    = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_nuget" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.nuget.id
  subnet_id      = data.azurerm_subnet.shared.id
}

# === APP: egos-tracking-api ===
resource "azurerm_service_plan" "egos_tracking_api" {
  provider            = azurerm.uat
  name                = "asp-wwe-egos-egos-tracking-api-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  os_type             = "Windows"
  sku_name            = local.sku_name
}

resource "azurerm_windows_web_app" "egos_tracking_api" {
  provider            = azurerm.uat
  name                = "ase2-wwe-egos-egos-tracking-api-uat-eastus2"
  location            = local.region
  resource_group_name = data.azurerm_resource_group.uat.name
  service_plan_id     = azurerm_service_plan.egos_tracking_api.id
  virtual_network_subnet_id = data.azurerm_subnet.shared.id

  site_config {
    always_on              = true
    minimum_tls_version    = "1.2"
    vnet_route_all_enabled = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }

    ip_restriction {
      name        = "AllowFrontdoor"
      priority    = 10
      action      = "Allow"
      service_tag = "AzureFrontDoor.Backend"
      headers     = []
    }

    ip_restriction_default_action = "Deny"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.shared_identity.id]
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings,
      site_config
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "uat_egos_tracking_api" {
  provider       = azurerm.uat
  app_service_id = azurerm_windows_web_app.egos_tracking_api.id
  subnet_id      = data.azurerm_subnet.shared.id
}
