variable "environment" {
  type        = string
  description = "(required) environment name for deployment"
}
variable "organization_suffix" {
  type        = string
  description = "(required) organizational suffix to seed into globaly unique names for resources"
}
variable "region" {
  type        = string
  description = "(requied) azure region where resources will be deployed"
}
variable "tenant_id" {
  type        = string
}
variable "app_type" {
  type = string
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "resource_group" {
  type        = string
  description = "Resource group name"
}

variable "profile_name" {
  type        = string
  description = "Front Door profile name"
}

variable "endpoint_name" {
  type        = string
  description = "Front Door endpoint name"
}


variable "afd_origin_groups" {
  type = map(object({
    health_probe_path    = string
    health_probe_method  = string
    health_probe_enabled = bool
    load_balancing_sample_size = number
    load_balancing_successful_samples_required = number
    origins             = list(string)
  }))
  description = "Map of origin groups for Front Door"
  default     = {}
}

variable "afd_routes" {
  type = map(object({
    endpoint_name     = string
    origin_group_name = string
    patterns_to_match = list(string)
    forwarding_protocol = string
  }))
  description = "Map of routes for Front Door"
  default     = {}
}

variable "afd_secrets" {
  type = map(object({
    secret_type = string
    secret_value = string
  }))
  description = "Map of secrets (e.g., TLS certs)"
  default     = {}
}

variable "afd_security_policies" {
  type = map(object({
    waf_enabled    = bool
    waf_policy_id  = string
  }))
  description = "Map of security policies"
  default     = {}
}
variable "afd_origins" {
  type = map(object({
    host_name           = string
    http_port           = number
    https_port          = number
    enabled             = bool
    priority            = number
    weight              = number
    origin_group_key    = string  
  }))
  description = "Map of origins for Front Door"
  default     = {}
}

variable "afd_profile_name" {}
variable "afd_endpoint_name" {}
variable "afd_sku" {}
variable "origin_group_name" {}
variable "origin_name" {}
variable "origin_hostname" {}
variable "route_name" {}
variable "secret_name" {}
variable "kv_secret_name" {}
variable "kv_secret_version" {}
variable "kv_id" {}
variable "security_policy_name" {}
variable "waf_policy_id" {}
variable "resource_group_name" {}
variable "tags" {
  type    = map(string)
  default = {}
}
variable waf_policies{}
variable "custom_domain_name" {
  description = "The name of the custom domain resource"
  type        = string
}

variable "custom_domain_hostname" {
  description = "The full hostname (FQDN) for the custom domain"
  type        = string
}
