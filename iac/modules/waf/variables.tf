variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "custom_rules" {
  type = list(any)
}
variable "managed_rules" {
  type = any
}
variable "policy_settings" {
  type = any
}
variable "application_gateway_ids" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "environment"{
  type = string  
 }
variable "organization_suffix"{
  type = string  
 }
variable "region"{
  type = string  
 } 
variable "app_type"{
  type = string  
}