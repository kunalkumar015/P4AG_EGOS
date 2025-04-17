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
variable "privateendpoints_address_space" {
  type = string
}
variable "vnet_address_space_devops" {
  type = string
}
variable "devops_address_space" {
  type = string
}


