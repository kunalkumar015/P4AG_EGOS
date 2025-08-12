# resource "azurerm_web_application_firewall_policy" "waf_policy" {
#   name                = var.waf_policy_name
#   resource_group_name = "rg-wwe-dev"
#   location            = "Global"

#   tags = var.tags

#   sku {
#     name = "Classic_AzureFrontDoor"
#   }

#   policy_settings {
#     enabled                     = true
#     mode                        = "Prevention"
#     request_body_check          = false
#     custom_block_response_status_code = 403
#   }

#   dynamic "custom_rules" {
#     for_each = var.custom_rules
#     content {
#       name      = custom_rules.value.name
#       priority  = custom_rules.value.priority
#       rule_type = custom_rules.value.rule_type
#       action    = custom_rules.value.action
#       enabled   = lookup(custom_rules.value, "enabled", true)

#       dynamic "match_conditions" {
#   for_each = custom_rules.value.match_conditions
#   content {
#     operator       = match_conditions.value.operator
#     match_values   = match_conditions.value.match_values

#     selector   = try(match_conditions.value.selector, null)
#     transforms = try(match_conditions.value.transforms, null)
#   }
# }


#       rate_limit_threshold           = lookup(custom_rules.value, "rate_limit_threshold", null)
#     }
#   }

#   managed_rules {
#     dynamic "managed_rule_set" {
#       for_each = var.managed_rule_sets
#       content {
#         type    = managed_rule_set.value.type
#         version = managed_rule_set.value.version

#         dynamic "rule_group_override" {
#           for_each = lookup(managed_rule_set.value, "rule_group_overrides", [])
#           content {
#             rule_group_name = rule_group_override.value.rule_group_name

#             dynamic "rule" {
#               for_each = rule_group_override.value.rules
#               content {
#                 rule_id = rule.value.rule_id
#                 action  = rule.value.action

#                 dynamic "exclusion" {
#                   for_each = lookup(rule.value, "exclusions", [])
#                   content {
#                     match_variable          = exclusion.value.match_variable
#                     selector_match_operator = exclusion.value.selector_match_operator
#                     selector                = exclusion.value.selector
#                   }
#                 }
#               }
#             }
#           }
#         }

#         dynamic "exclusion" {
#           for_each = lookup(managed_rule_set.value, "exclusions", [])
#           content {
#             match_variable          = exclusion.value.match_variable
#             selector_match_operator = exclusion.value.selector_match_operator
#             selector                = exclusion.value.selector
#           }
#         }
#       }
#     }
#   }
# }
