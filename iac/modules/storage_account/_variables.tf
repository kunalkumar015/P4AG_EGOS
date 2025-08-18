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
## Storage variables
variable "storage_account_name" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "storage" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "diagnostic_storage_accounts" {
  description = "Configuration object - Storage account for diagnostics resources"
  default     = {}
}
variable "location" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "account_tier" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "account_replication_type" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "account_kind" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "access_tier" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "enable_https_traffic_only" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "infrastructure_encryption_enabled" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "min_tls_version" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "app_type" {
  type = string
  description = "(required) app type for deployment"
}
variable "private_endpoint_subnet_id" {
  type = string
  description = "(required) pe for sa"
}