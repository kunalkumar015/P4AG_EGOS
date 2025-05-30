
resource "azurerm_network_security_group" "private_endpoint" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.private_endpoint.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

      lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "private_endpoint" {
  subnet_id                 = azurerm_subnet.private_endpoint.id
  network_security_group_id = azurerm_network_security_group.private_endpoint.id

}
resource "azurerm_network_security_group" "nuget" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.nuget.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "nuget" {
  subnet_id                 = azurerm_subnet.nuget.id
  network_security_group_id = azurerm_network_security_group.nuget.id
}
resource "azurerm_network_security_group" "dao" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.dao.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "dao" {
  subnet_id                 = azurerm_subnet.webapps.id
  network_security_group_id = azurerm_network_security_group.dao.id
}
resource "azurerm_network_security_group" "webservices" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.webservices.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "webservices" {
  subnet_id                 = azurerm_subnet.webapps.id
  network_security_group_id = azurerm_network_security_group.webservices.id
}
resource "azurerm_network_security_group" "dashboard" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.dashboard.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "dashboard" {
  subnet_id                 = azurerm_subnet.webapps.id
  network_security_group_id = azurerm_network_security_group.dashboard.id
}
resource "azurerm_network_security_group" "egosapi" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.egosapi.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "egosapi" {
  subnet_id                 = azurerm_subnet.webapps.id
  network_security_group_id = azurerm_network_security_group.egosapi.id
}
resource "azurerm_network_security_group" "tradedirect" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.tradedirect.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "tradedirect" {
  subnet_id                 = azurerm_subnet.webapps.id
  network_security_group_id = azurerm_network_security_group.tradedirect.id
}
resource "azurerm_network_security_group" "opstrackingwebapi" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.opstrackingwebapi.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "opstrackingwebapi" {
  subnet_id                 = azurerm_subnet.webapps.id
  network_security_group_id = azurerm_network_security_group.opstrackingwebapi.id
}
resource "azurerm_network_security_group" "hangfire" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.hangfire.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "hangfire" {
  subnet_id                 = azurerm_subnet.webapps.id
  network_security_group_id = azurerm_network_security_group.hangfire.id
}
resource "azurerm_network_security_group" "princepdf" {
  name                 = "nsg-wwe-${local.app_type}-${replace(azurerm_subnet.princepdf.name, "snet-", "")}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
       
        lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_subnet_network_security_group_association" "princepdf" {
  subnet_id                 = azurerm_subnet.webapps.id
  network_security_group_id = azurerm_network_security_group.princepdf.id
}