variable "app_services" {
  type = list(string)
  default = [
    "ase2-wwe-egos-egos-tracking-api-dev-eastus2",
    "ase2-wwe-egos-egosapi-dev-eastus2",
    "ase2-wwe-egos-hangfire-dev-eastus2",
    "ase2-wwe-egos-nuget-dev-eastus2",
    "ase2-wwe-egos-opstrackingwebapi-dev-eastus2",
    "ase2-wwe-egos-tradedirect-dev-eastus2",
    "ase2-wwe-egos-webservices-dev-eastus2",
    "ase2-wwe-ga-carthandoff-dev-eastus2",
    "ase2-wwe-ga-classifying-dev-eastus2",
    "ase2-wwe-ga-dashboard-dev-eastus2",
    "ase2-wwe-ga-globalcheckout-dev-eastus2",
    "ase2-wwe-ga-hangfire-dev-eastus2",
    "ase2-wwe-ga-label-dev-eastus2",
    "ase2-wwe-ga-prince-pdf2-dev-eastus2",
    "ase2-wwe-ga-shopifyintegrationws-dev-eastus2"
  ]
}

resource "azurerm_private_endpoint" "app_service_pe" {
  for_each = toset(var.app_services)

  name                = "pep-${each.key}"
  location            = "eastus2"
  resource_group_name = "rg-wwe-dev"
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${each.key}"
    private_connection_resource_id = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Web/sites/${each.key}"
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = ["/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"]
  }

  tags = {
    environment = "dev"
  }
}