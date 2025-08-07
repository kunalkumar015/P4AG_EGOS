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
variable "tenant_id" {
  type        = string
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

# variable "webapps_subnet_address" {
#   type = string
# }


variable "shared_subnet_address" {
  type = string
}

variable "app_name" {
  type        = string
  description = "(required) appS name for deployment"
  default = null
}

variable "app_sku" {
  type = string
  description = "(required) sku name for deployment"
}
variable "app_type" {
  type = string
  description = "(required) app type for deployment"
}
variable "create_redis_link" {
  type = any
}

variable "account_replication_type" {
  type = string
  default = "LRS"
}
variable "asp_zone_balancing_enabled" {
  type = string
  description = "(required) app name for deployment"
}
variable "redis_sku" {
  type = string
}
variable "redis_sku_family" {
  type = string
}

variable "sql_private_dns_zone_id" {
  type        = string
  description = "ID of the private DNS zone for Azure SQL"
}

variable "cosmosdb_private_dns_zone_id" {
  type        = string
  description = "ID of the Private DNS Zone for Cosmos DB"
}
variable "subnet_id" {
  type        = string
  description = "ID of the Private DNS Zone for Cosmos DB"
}

variable "afd_profile_name" {
  type        = string
  description = "name of az front door"
}

variable "waf_policy_id" {
  description = "The resource ID of the Azure Web Application Firewall Policy."
  type        = string
}

variable "kv_id" {
  description = "The resource ID of the Azure Key Vault containing secrets used by AFD."
  type        = string
}

variable "waf_policies" {
  description = "Map of Web Application Firewall policies configuration."
  type = map(object({
    waf_enabled = bool
    # Add other WAF-specific properties if needed
  }))
  default = {}
}

variable "resource_group_name" {
  description = "The name of the resource group where resources will be deployed."
  type        = string
}


variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

variable "custom_domain_name" {
  description = "The name of the custom domain resource"
  type        = string
}

variable "custom_domain_hostname" {
  description = "The full hostname (FQDN) for the custom domain"
  type        = string
}

variable "agw_name" {}
variable "identity_ids" {
  type = list(string)
}
variable "backend_fqdn" {}
variable "snet_agw_id" {} 
variable "ssl_certificate_name" {}
variable "key_vault_rg"{}
variable "key_vault_name"{}
variable "agwsnet_address_space"{}
variable "sql_admin_password" {}
# variable "nuget_address_space" {
#   type = string
# }
# variable "dao_address_space" {
#   type = string
# }
# variable "webservices_address_space" {
#   type = string
# }
# variable "dashboard_address_space" {
#   type = string
# }
# variable "egosapi_address_space" {
#   type = string
# }
# variable "tradedirect_address_space" {
#   type = string
# }
# variable "opstrackingwebapi_address_space" {
#   type = string
# }
# variable "hangfire_address_space" {
#   type = string
# }
# variable "princepdf_address_space" {
#   type = string
# }

variable "region" {
  type        = string
  description = "(requied) azure region where resources will be deployed"
}

