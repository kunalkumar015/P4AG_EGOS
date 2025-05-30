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
vnet_address_space             = "172.22.34.128/26" #172.22.34.160/27 --32 ips-5=27
webapps_subnet_address         = "172.22.34.128/27"
# privateendpoints_address_space = "172.22.34.192/27"
app_sku                        = "S1"
app_type                       = "egos"
account_replication_type       = "LRS"
app_name                       = null
create_redis_link              = 0
redis_sku                      = "Standard"
redis_sku_family               = "C"
asp_zone_balancing_enabled     = "false"