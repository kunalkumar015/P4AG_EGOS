locals {
  dashboard_custom_rules = [
    {
      name     = "IPblock"
      priority = 1
      rule_type = "MatchRule"
      action    = "Block"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            {
              variable_name = "RemoteAddr"
            }
          ]
          operator           = "IPMatch"
          negationConditon   = false
          match_values       = ["142.93.11.130"]
          transforms         = []
        }
      ]
    },
    {
      name     = "DevIPsOnly"
      priority = 2
      rule_type = "MatchRule"
      action    = "Block"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            {
              variable_name = "RemoteAddr"
            }
          ]
          operator           = "IPMatch"
          negationConditon   = true
          match_values       = [
            "4.236.204.224/29",
            "20.22.31.168/29",
            "52.250.94.160/29",
            "4.255.42.32/29",
            "20.10.110.152/29",
            "104.40.38.112/29",
            "20.120.141.40/29",
            "74.249.20.96/29",
            "156.134.64.67",
            "156.134.96.67",
            "47.204.240.238",
            "136.226.58.89"
          ]
          transforms = []
        }
      ]
    },
    {
      name     = "extjs"
      priority = 3
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "QueryString" }
          ]
          operator           = "Contains"
          negationConditon   = false
          match_values       = ["_dc="]
          transforms         = []
        }
      ]
    },
    {
      name     = "staticurls"
      priority = 4
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator           = "EndsWith"
          negationConditon   = false
          match_values       = [
            "/Dashboard/CompaniesCount",
            "/BillingAdjustments/Index",
            "/favicon.ico",
            "Error/_500"
          ]
          transforms         = []
        }
      ]
    },
    {
      name     = "IPAllowNetsparker"
      priority = 10
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RemoteAddr" }
          ]
          operator           = "IPMatch"
          negationConditon   = false
          match_values       = [
            "153.2.246.0/24",
            "153.2.247.0/24",
            "34.237.50.127",
            "54.85.169.114",
            "54.88.149.100"
          ]
          transforms         = []
        }
      ]
    },
    {
      name     = "webservicesv2"
      priority = 15
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator         = "BeginsWith"
          negationConditon = false
          match_values     = ["/v2.0/api/"]
          transforms       = []
        }
      ]
    },
    {
      name     = "signalr"
      priority = 20
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator         = "BeginsWith"
          negationConditon = false
          match_values     = ["/signalr/"]
          transforms       = []
        }
      ]
    },
    {
      name     = "AddNewMerchant"
      priority = 30
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator         = "Equal"
          negationConditon = false
          match_values     = ["/Account/Register"]
          transforms       = []
        }
      ]
    },
    {
      name     = "ApiDashFeedback"
      priority = 40
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator         = "BeginsWith"
          negationConditon = false
          match_values     = ["/api/DashFeedback"]
          transforms       = []
        }
      ]
    },
    {
      name     = "BusinessEdit"
      priority = 50
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator         = "Equal"
          negationConditon = false
          match_values     = ["/Business/Edit"]
          transforms       = []
        }
      ]
    },
    {
      name     = "Classification"
      priority = 60
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator         = "Equal"
          negationConditon = false
          match_values     = [
            "/classification/countryupload",
            "/classification/uploadclassification",
            "/classification/parcelclassifications"
          ]
          transforms       = ["Lowercase"]
        }
      ]
    },
    {
      name     = "AccountNewPassword"
      priority = 70
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator         = "Equal"
          negationConditon = false
          match_values     = ["/Account/NewPassword"]
          transforms       = []
        }
      ]
    },
    {
      name     = "DownloadBlobFile"
      priority = 80
      rule_type = "MatchRule"
      action    = "Allow"
      state     = "Enabled"
      match_conditions = [
        {
          match_variables = [
            { variable_name = "RequestUri" }
          ]
          operator         = "Contains"
          negationConditon = false
          match_values     = ["DownloadFileFromBlob?filePath="]
          transforms       = []
        }
      ]
    }
  ]


  policy_settings = {
    requestBodyCheck       = true
    maxRequestBodySizeInKb = 128
    fileUploadLimitInMb    = 100
    state                  = "Enabled"
    mode                   = "Prevention"
  }

  managed_rules = {
    managedRuleSets = [
      {
        ruleSetType    = "OWASP"
        ruleSetVersion = "3.1"
      },
      {
        ruleSetType    = "Microsoft_BotManagerRuleSet"
        ruleSetVersion = "1.0"
      }
    ]
  }

  
  //webservices

  webservices_custom_rules = [
    {
      name     = "DevIPsOnly"
      priority = 2
      rule_type = "MatchRule"
      action   = "Block"
      match_conditions = [
        {
          match_variables = [
            {
              variable_name = "RemoteAddr"
            }
          ]
          operator            = "IPMatch"
          negation_condition = true
          match_values = [
            "4.236.204.224/29",
            "20.22.31.168/29",
            "52.250.94.160/29",
            "4.255.42.32/29",
            "20.10.110.152/29",
            "104.40.38.112/29",
            "20.120.141.40/29",
            "74.249.20.96/29",
            "156.134.64.67",
            "156.134.96.67",
            "47.204.240.238",
            "40.86.116.0/29"
          ]
        }
      ]
    },
    {
      name     = "IPAllowNetsparker"
      priority = 10
      rule_type = "MatchRule"
      action   = "Allow"
      match_conditions = [
        {
          match_variables = [
            {
              variable_name = "RemoteAddr"
            }
          ]
          operator            = "IPMatch"
          negation_condition = false
          match_values = [
            "54.88.149.100",
            "54.85.169.114",
            "34.237.50.127",
            "153.2.247.0/24",
            "153.2.246.0/24"
          ]
        }
      ]
    },
    {
      name     = "Merchant"
      priority = 100
      rule_type = "MatchRule"
      action   = "Allow"
      match_conditions = [
        {
          match_variables = [
            {
              variable_name = "RequestUri"
            }
          ]
          operator            = "BeginsWith"
          negation_condition = false
          match_values = [
            "/v2.0/api/Merchant"
          ]
        }
      ]
    }
  ]
}



 