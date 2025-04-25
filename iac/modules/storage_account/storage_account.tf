resource "azurerm_storage_account" "stacc" {
  name                              = var.storage_account_name
  location                          = data.azurerm_resource_group.resource_group.location
  resource_group_name               = data.azurerm_resource_group.resource_group.name
  account_tier                      = var.account_tier
  account_replication_type          = var.account_replication_type
  account_kind                      = var.account_kind
  access_tier                       = var.access_tier
  min_tls_version                   = "TLS1_2"
  https_traffic_only_enabled        = true
  public_network_access_enabled     = false
  
    lifecycle {
    ignore_changes = [
      location, resource_group_name, tags
    ]
  }
  #allow_nested_items_to_be_public   = try(var.allow_nested_items_to_be_public, var.allow_blob_public_access, false)
  #cross_tenant_replication_enabled  = try(var.cross_tenant_replication_enabled, null)
  #edge_zone                         = try(var.edge_zone, null)
  #large_file_share_enabled          = try(var.large_file_share_enabled, null)
  # is_hns_enabled                    = try(var.is_hns_enabled, false)
  # sftp_enabled                      = try(var.sftp_enabled, null)
  # nfsv3_enabled                     = try(var.nfsv3_enabled, false)
  # queue_encryption_key_type         = try(var.queue_encryption_key_type, null)
  # table_encryption_key_type         = try(var.table_encryption_key_type, null)
  # public_network_access_enabled     = try(var.public_network_access_enabled, null)

  # dynamic "network_rules" {
  #   for_each = lookup(var.storage_account, "network", null) == null ? [] : [1]
  #   content {
  #     bypass         = try(var.network.bypass, [])
  #     default_action = try(var.network.default_action, "Deny")
  #     ip_rules       = try(var.network.ip_rules, [])
  #     virtual_network_subnet_ids = try(var.network.subnets, null) == null ? null : [
  #       for key, value in var.network.subnets : can(value.remote_subnet_id) ? value.remote_subnet_id : var.vnets[try(value.lz_key, var.client_config.landingzone_key)][value.vnet_key].subnets[value.subnet_key].id
  #     ]
  #   }
  # }


  # dynamic "custom_domain" {
  #   for_each = lookup(var.storage_account, "custom_domain", false) == false ? [] : [1]

  #   content {
  #     name          = var.custom_domain.name
  #     use_subdomain = try(var.custom_domain.use_subdomain, null)
  #   }
  # }

  # dynamic "identity" {
  #   for_each = lookup(var.storage_account, "enable_system_msi", false) == false ? [] : [1]

  #   content {
  #     type = "SystemAssigned"
  #   }
  # }

  # dynamic "identity" {
  #   for_each = can(var.identity) ? [var.identity] : []

  #   content {
  #     type         = identity.value.type
  #     identity_ids = local.managed_identities
  #   }
  # }

  # dynamic "blob_properties" {
  #   for_each = lookup(var.storage_account, "blob_properties", false) == false ? [] : [1]

  #   content {
  #     versioning_enabled       = try(var.blob_properties.versioning_enabled, false)
  #     change_feed_enabled      = try(var.blob_properties.change_feed_enabled, false)
  #     default_service_version  = try(var.blob_properties.default_service_version, "2020-06-12")
  #     last_access_time_enabled = try(var.blob_properties.last_access_time_enabled, false)

  #     dynamic "cors_rule" {
  #       for_each = lookup(var.blob_properties, "cors_rule", false) == false ? [] : [1]

  #       content {
  #         allowed_headers    = var.blob_properties.cors_rule.allowed_headers
  #         allowed_methods    = var.blob_properties.cors_rule.allowed_methods
  #         allowed_origins    = var.blob_properties.cors_rule.allowed_origins
  #         exposed_headers    = var.blob_properties.cors_rule.exposed_headers
  #         max_age_in_seconds = var.blob_properties.cors_rule.max_age_in_seconds
  #       }
  #     }

  #     dynamic "delete_retention_policy" {
  #       for_each = lookup(var.blob_properties, "delete_retention_policy", false) == false ? [] : [1]

  #       content {
  #         days = try(var.blob_properties.delete_retention_policy.delete_retention_policy, 7)
  #       }
  #     }

  #     dynamic "container_delete_retention_policy" {
  #       for_each = lookup(var.blob_properties, "container_delete_retention_policy", false) == false ? [] : [1]

  #       content {
  #         days = try(var.blob_properties.container_delete_retention_policy.container_delete_retention_policy, 7)
  #       }
  #     }
  #   }
  # }

  # dynamic "queue_properties" {
  #   for_each = lookup(var.storage_account, "queue_properties", false) == false ? [] : [1]

  #   content {
  #     dynamic "cors_rule" {
  #       for_each = lookup(var.queue_properties, "cors_rule", false) == false ? [] : [1]

  #       content {
  #         allowed_headers    = var.queue_properties.cors_rule.allowed_headers
  #         allowed_methods    = var.queue_properties.cors_rule.allowed_methods
  #         allowed_origins    = var.queue_properties.cors_rule.allowed_origins
  #         exposed_headers    = var.queue_properties.cors_rule.exposed_headers
  #         max_age_in_seconds = var.queue_properties.cors_rule.max_age_in_seconds
  #       }
  #     }

  #     dynamic "logging" {
  #       for_each = lookup(var.queue_properties, "logging", false) == false ? [] : [1]

  #       content {
  #         delete                = var.queue_properties.logging.delete
  #         read                  = var.queue_properties.logging.read
  #         write                 = var.queue_properties.logging.write
  #         version               = var.queue_properties.logging.version
  #         retention_policy_days = try(var.queue_properties.logging.retention_policy_days, 7)
  #       }
  #     }

  #     dynamic "minute_metrics" {
  #       for_each = lookup(var.queue_properties, "minute_metrics", false) == false ? [] : [1]

  #       content {
  #         enabled               = var.queue_properties.minute_metrics.enabled
  #         version               = var.queue_properties.minute_metrics.version
  #         include_apis          = try(var.queue_properties.minute_metrics.include_apis, null)
  #         retention_policy_days = try(var.queue_properties.minute_metrics.retention_policy_days, 7)
  #       }
  #     }

  #     dynamic "hour_metrics" {
  #       for_each = lookup(var.queue_properties, "hour_metrics", false) == false ? [] : [1]

  #       content {
  #         enabled               = var.queue_properties.hour_metrics.enabled
  #         version               = var.queue_properties.hour_metrics.version
  #         include_apis          = try(var.queue_properties.hour_metrics.include_apis, null)
  #         retention_policy_days = try(var.queue_properties.hour_metrics.retention_policy_days, 7)
  #       }
  #     }
  #   }
  # }

  # dynamic "static_website" {
  #   for_each = lookup(var.storage_account, "static_website", false) == false ? [] : [1]

  #   content {
  #     index_document     = try(var.static_website.index_document, null)
  #     error_404_document = try(var.static_website.error_404_document, null)
  #   }
  # }


  # dynamic "azure_files_authentication" {
  #   for_each = lookup(var.storage_account, "azure_files_authentication", false) == false ? [] : [1]

  #   content {
  #     directory_type = var.azure_files_authentication.directory_type

  #     dynamic "active_directory" {
  #       for_each = lookup(var.azure_files_authentication, "active_directory", false) == false ? [] : [1]

  #       content {
  #         storage_sid         = var.azure_files_authentication.active_directory.storage_sid
  #         domain_name         = var.azure_files_authentication.active_directory.domain_name
  #         domain_sid          = var.azure_files_authentication.active_directory.domain_sid
  #         domain_guid         = var.azure_files_authentication.active_directory.domain_guid
  #         forest_name         = var.azure_files_authentication.active_directory.forest_name
  #         netbios_domain_name = var.azure_files_authentication.active_directory.netbios_domain_name
  #       }
  #     }
  #   }
  }



