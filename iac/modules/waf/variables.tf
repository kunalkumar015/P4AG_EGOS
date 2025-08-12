# variable "waf_policy_name" {
#   type        = string
#   description = "The name of the WAF policy"
# }

# variable "tags" {
#   type        = map(string)
#   description = "Tags to apply to the WAF policy"
#   default     = {}
# }

# variable "custom_rules" {
#   type = list(object({
#     name        = string
#     priority    = number
#     rule_type   = string
#     action      = string
#     match_variable = string
#     operator    = string
#     match_values = list(string)
#     selector     = optional(string)
#     transforms   = optional(list(string))
#     enabled      = optional(bool)
#     rate_limit_threshold           = optional(number)
#     rate_limit_duration_in_minutes = optional(number)
#   }))
#   default = []
# }

# variable "managed_rule_sets" {
#   description = "List of managed rule sets with optional exclusions and overrides"
#   type = list(object({
#     type    = string
#     version = string
#     exclusions = optional(list(object({
#       match_variable          = string
#       selector_match_operator = string
#       selector                = string
#     })))
#     rule_group_overrides = optional(list(object({
#       rule_group_name = string
#       rules = list(object({
#         rule_id = string
#         action  = string
#         exclusions = optional(list(object({
#           match_variable          = string
#           selector_match_operator = string
#           selector                = string
#         })))
#       }))
#     })))
#   }))
#   default = []
# }
