# subscription_id                       = "b09bcb9d-e055-4950-a9dd-2ab6002ef86c"
# vnet_address_space                    = "10.60.0.0/22"
# privateendpoints_address_space        = "10.60.0.0/27"
# appgw_subnet_web_address_space        = "10.60.0.32/27"
# appgw_subnet_dash_address_space       = "10.60.0.64/27"
# webservices_address_space             = "10.60.0.96/27"
# dashboard_address_space               = "10.60.0.128/27"
# carthandoff_address_space             = "10.60.0.160/27"
# classifying_address_space             = "10.60.0.192/27"
# webjobs_address_space                 = "10.60.0.224/27"
# globalcheckout_address_space          = "10.60.1.0/27"
# hangfire_address_space                = "10.60.1.32/27"
# shopifyintegrationws_address_space    = "10.60.1.64/27"
# tracking_address_space                = "10.60.1.96/27"
# iaas_address_space                    = "10.60.1.128/27"
# app_sku                               = "P2v2"
# app_type                              = "ga"
# app_name                              = null
# create_redis_link                     = 0
# redis_sku                             = "Standard"
# redis_sku_family                      = "C"
# asp_zone_balancing_enabled            = "false"


subscription_id                = "b09bcb9d-e055-4950-a9dd-2ab6002ef86c"
vnet_address_space             = "10.235.89.160/27" #172.22.34.160/27 (too small)
shared_subnet_address         = "10.235.89.160/28"
//privateendpoints_address_space = "10.235.89.176/29"

app_sku                        = "B2"
app_type                       = "ga"
app_name                       = null
create_redis_link              = 0
redis_sku                      = "Standard"
redis_sku_family               = "C"
asp_zone_balancing_enabled     = "false"
resource_group_name            = "rg-wwe-dev"
#wwe_ga_subnet_address_space    = "10.60.1.96/27"
sql_admin_password             ="nY3f@xCz#Vq2Lb8J%pK7$Mw9UzD1^tR6"
agwsnet_address_space           = "10.235.89.176/28"
sql_private_dns_zone_id        = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"



#------AGW------------------------------------------
agw_name                       = "agw-dev-eastus2"
location                       = "eastus2"
environment                    = "dev"
backend_fqdn                   = "ase2-wwe-ga-webservices-dev-eastus2.azurewebsites.net"
ssl_certificate_name           = "yellow-wweconomy-ups-com"
identity_ids = [
  "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/uami-agw-dev-eastus2"
]
snet_agw_id                    = "/subscriptions/b09bcb9d-e055-4950-a9dd-2ab6002ef86c/resourceGroups/rg-wwe-dev/providers/Microsoft.Network/virtualNetworks/vnet-wwe-ga-dev-eastus2/subnets/snet_agw"

