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
variable "agw_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "firewall_policy_id" {}
variable "public_ip_address_id" {}
variable "subnet_id" {}
variable "backend_fqdn" {}
variable "ssl_certificate_name" {}
variable "identity_ids" {
  type = list(string)
}
variable "key_vault_rg"{}
variable "key_vault_name"{}