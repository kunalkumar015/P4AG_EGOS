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

variable "app_type" {
  type = string
}
variable "sku_name" {
  type = string
}
variable "family" {
  type = string
}
variable "capacity" {
  type = string
}
variable "create_redis_link" {
  type = any
}