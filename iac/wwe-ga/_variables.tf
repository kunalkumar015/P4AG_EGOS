variable "environment" {
  type        = string
  description = "(required) environment name for deployment"
}
variable "organization_suffix" {
  type        = string
  description = "(required) organizational suffix to seed into globaly unique names for resources"
}
variable "location" {
  type        = string
  description = "(requied) azure region where resources will be deployed"
}
variable "subscription_id" {
  type = string
}
variable "vnet_address_space" {
  type = string
}
# variable "privateendpoints_address_space" {
#   type = string
# }
variable "resource_group_name" {
  type = string
}
# variable "appgw_subnet_web_address_space" {
#   type = string
# }
# variable "appgw_subnet_dash_address_space" {
#   type = string
# }
# variable "webservices_address_space" {
#   type = string
# }
# variable "dashboard_address_space" {
#   type = string
# }
# variable "carthandoff_address_space" {
#   type = string
# }
# variable "classifying_address_space" {
#   type = string
# }
# variable "webjobs_address_space" {
#   type = string
# }
# variable "globalcheckout_address_space" {
#   type = string
# }
# variable "hangfire_address_space" {
#   type = string
# }
# variable "shopifyintegrationws_address_space" {
#   type = string
# }
# variable "tracking_address_space" {
#   type = string
# }
# variable "iaas_address_space" {
#   type = string
# }

# variable "wwe_ga_subnet_address_space" {
#   type = string
# }

variable "shared_subnet_address" {
  type = string
}

variable "app_name" {
  type        = string
  description = "(required) appS name for deployment"
}

variable "app_sku" {
  type        = string
  description = "(required) sku name for deployment"
}
variable "app_type" {
  type        = string
  description = "(required) app type for deployment"
}
variable "create_redis_link" {
  type = any
}
variable "redis_sku" {
  type = string
}
variable "redis_sku_family" {
  type = string
}
variable "asp_zone_balancing_enabled" {
  type        = string
  description = "(required) app name for deployment"
}
 variable "sql_admin_password" {
    type        = string
  description = "(required) sql password"
 }