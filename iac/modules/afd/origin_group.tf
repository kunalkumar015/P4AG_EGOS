# resource "azurerm_cdn_frontdoor_origin_group" "afd_origin_groups" {
#   for_each = var.afd_origin_groups

#   name                      = each.key
#   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.afdProfile.id

#   load_balancing {
#     sample_size                 = each.value.load_balancing_sample_size
#     successful_samples_required = each.value.load_balancing_successful_samples_required
#   }

#   health_probe {
#     path                = each.value.health_probe_path
#     protocol            = each.value.health_probe_protocol
#     request_type        = each.value.health_probe_method
#     interval_in_seconds = each.value.health_probe_interval
#   }
# }

resource "azurerm_cdn_frontdoor_origin_group" "afdOrigin_group" {
  name                        = var.origin_group_name
  cdn_frontdoor_profile_id   = azurerm_cdn_frontdoor_profile.afdProfile.id

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }

  health_probe {
    interval_in_seconds = 120
    path                = "/"
    protocol            = "Https"
    request_type        = "GET"
  }
}
