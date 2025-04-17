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
# variable "subnet" {
#   type = object({
#     id                   = string
#     name                 = string
#     resource_group_name  = string
#     virtual_network_name = string
#   })
# }


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