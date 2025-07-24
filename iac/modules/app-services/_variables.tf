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

variable "resource_group_name" {}


variable "app_sku" {
  type = string
  description = "(required) sku name for deployment"
}
variable "app_type" {
  type = string
  description = "(required) app type for deployment"
}
variable "app_name" {
  type = string
  description = "(required) app name for deployment"
}
variable "asp_zone_balancing_enabled" {
  type = string
  description = "(required) app name for deployment"
}
variable "subnet_id" {
  type = string
  description = "(required) subnet app service will integrate into"
}