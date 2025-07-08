
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
