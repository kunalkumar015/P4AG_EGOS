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
