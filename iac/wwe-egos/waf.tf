# module "waf_policy_egos_dashboard" {
#   source           = "./modules/waf_policy"
#   waf_policy_name  = "egosDashboardDevWaf"

#   tags = {
#     environment = "dev"
#     app         = "dashboard"
#     subproject  = "egos-dev"
#   }

#   custom_rules = [
#     {
#       name        = "Extjs"
#       priority    = 100
#       rule_type   = "MatchRule"
#       action      = "Allow"
#       match_variable = "RequestUri"
#       operator    = "Contains"
#       match_values = ["_dc="]
#     },
#     {
#       name        = "IPAllowNetsparker"
#       priority    = 10
#       rule_type   = "MatchRule"
#       action      = "Allow"
#       match_variable = "RemoteAddr"
#       operator    = "IPMatch"
#       match_values = [
#         "153.2.246.0/24",
#         "153.2.247.0/24",
#         "34.237.50.127",
#         "54.85.169.114",
#         "54.88.149.100"
#       ]
#     }
#   ]

#   managed_rule_sets = [
#     {
#       type    = "Microsoft_DefaultRuleSet"
#       version = "1.1"
#       exclusions = [
#         {
#           match_variable          = "RequestCookieNames"
#           selector_match_operator = "Equals"
#           selector                = "LtpaToken"
#         }
#       ]
#       rule_group_overrides = [
#         {
#           rule_group_name = "SQLI"
#           rules = [
#             {
#               rule_id = "942230"
#               action  = "Block"
#             },
#             {
#               rule_id = "942340"
#               action  = "Block"
#               exclusions = [
#                 {
#                   match_variable          = "RequestCookieNames"
#                   selector_match_operator = "Equals"
#                   selector                = "LtpaToken"
#                 }
#               ]
#             }
#           ]
#         }
#       ]
#     },
#     {
#       type    = "Microsoft_BotManagerRuleSet"
#       version = "1.0"
#     }
#   ]
# }
