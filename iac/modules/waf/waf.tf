resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "custom_rules" {
    for_each = local.dashboard_custom_rules
    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type
      action    = custom_rules.value.action
    #   state     = try(custom_rules.value.state, "Enabled")

      dynamic "match_conditions" {
        for_each = custom_rules.value.match_conditions
        content {
          match_variables {
            variable_name = match_conditions.value.match_variables[0].variable_name
          }
          operator            = match_conditions.value.operator
          negation_condition  = try(match_conditions.value.negationConditon, false)
          match_values        = match_conditions.value.match_values
          transforms          = try(match_conditions.value.transforms, [])
        }
      }
    }
  }

  policy_settings {
    request_body_check      = var.policy_settings.requestBodyCheck
    # max_request_body_size_kb = var.policy_settings.maxRequestBodySizeInKb
    # file_upload_limit_mb     = var.policy_settings.fileUploadLimitInMb
    # state                    = var.policy_settings.state
    mode                     = var.policy_settings.mode
  }

  managed_rules {
    dynamic "managed_rule_set" {
      for_each = var.managed_rules.managedRuleSets
      content {
        type    = managed_rule_set.value.ruleSetType
        version = managed_rule_set.value.ruleSetVersion
      }
    }
  }

}
