# tenant_id                             = "e7520e4d-d5a0-488d-9e9f-949faae7dce8"
# subscription_id                       = "b09bcb9d-e055-4950-a9dd-2ab6002ef86c"
# vnet_address_space                    = "10.62.0.0/22"
# privateendpoints_address_space        = "10.62.0.0/27"
# nuget_address_space                   = "10.62.0.32/27"
# dao_address_space                     = "10.62.0.64/27"
# webservices_address_space             = "10.62.0.96/27"
# dashboard_address_space               = "10.62.0.128/27"
# egosapi_address_space                 = "10.62.0.160/27"
# tradedirect_address_space             = "10.62.0.192/27"
# opstrackingwebapi_address_space       = "10.62.0.224/27"
# hangfire_address_space                = "10.62.1.0/27"
# princepdf_address_space               = "10.62.1.32/27"
# app_sku                               = "S1"
# app_type                              = "egos"
# account_replication_type              = "LRS"
# app_name                              = null
# create_redis_link                     = 0
# asp_zone_balancing_enabled            = false
# redis_sku                             = "Standard"
# redis_sku_family                      = "C"


tenant_id                      = "e7520e4d-d5a0-488d-9e9f-949faae7dce8"
subscription_id                = "b09bcb9d-e055-4950-a9dd-2ab6002ef86c"
vnet_address_space             = "10.235.89.128/27"
shared_subnet_address          = "10.235.89.128/28"
//webapps_subnet_address         = "10.235.89.128/28"
//privateendpoints_address_space = "10.235.89.128/28"//"10.235.89.144/29"//merge this with webapp
agwsnet_address_space          = "10.235.89.144/28" 
app_sku                        = "B2"
app_type                       = "egos"
account_replication_type       = "LRS"
app_name                       = null
create_redis_link              = 0
redis_sku                      = "Standard"
redis_sku_family               = "C"
asp_zone_balancing_enabled     = "false"
resource_group_name            = "rg-wwe-dev"
key_vault_name                 = "kv2-wwe-dev-eastus2-v3"
region                         = "eastus2"
key_vault_rg                   = "rg-wwe-dev"
sql_admin_password             ="nY3f@xCz#Vq2Lb8J%pK7$Mw9UzD1^tR6"
#------AFD---------------------------------------
afd_profile_name               = "afd-wwe-dev"
subnet_id                      = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/virtualNetworks/vnet-wwe-egos-dev-eastus2/subnets/snet-privateendpoints"
cosmosdb_private_dns_zone_id   = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/privateDnsZones/privatelink.documents.azure.com"
sql_private_dns_zone_id        = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"
kv_id                          = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.KeyVault/vaults/kv2-wwe-dev-eastus2"
waf_policy_id                  = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/egos-dev/providers/Microsoft.Cdn/frontDoorWebApplicationFirewallPolicies/egosDashboardDevWaf"
custom_domain_name             = "egosapi-dev-custom-domain"
custom_domain_hostname         = "egosapi.yellow.wweconomy.ups.com"


#------AGW------------------------------------------
agw_name                       = "agw-dev-eastus2"
location                       = "eastus2"
environment                    = "dev"
backend_fqdn                   = "ase2-wwe-ga-webservices-dev-eastus2.azurewebsites.net"
ssl_certificate_name           = "yellow-wweconomy-ups-com"
identity_ids = [
  "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/uami-agw-dev-eastus2"
]
snet_agw_id                    = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/virtualNetworks/vnet-wwe-egos-dev-eastus2/subnets/snet_agw"

