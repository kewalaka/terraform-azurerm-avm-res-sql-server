resource "azurerm_mssql_database" "this" {
  for_each = var.databases

  name                                = each.key
  server_id                           = try(data.azurerm_mssql_server.this[0].id, azurerm_mssql_server.this[0].id)
  auto_pause_delay_in_minutes         = each.value.auto_pause_delay_in_minutes
  create_mode                         = each.value.create_mode
  collation                           = each.value.collation
  elastic_pool_id                     = each.value.elastic_pool_id
  geo_backup_enabled                  = each.value.geo_backup_enabled
  maintenance_configuration_name      = each.value.maintenance_configuration_name
  ledger_enabled                      = each.value.ledger_enabled
  license_type                        = each.value.license_type
  max_size_gb                         = each.value.max_size_gb
  min_capacity                        = each.value.min_capacity
  restore_point_in_time               = each.value.restore_point_in_time
  recover_database_id                 = each.value.recover_database_id
  restore_dropped_database_id         = each.value.restore_dropped_database_id
  read_replica_count                  = each.value.read_replica_count
  read_scale                          = each.value.read_scale
  sample_name                         = each.value.sample_name
  sku_name                            = each.value.sku_name
  storage_account_type                = each.value.storage_account_type
  transparent_data_encryption_enabled = each.value.transparent_data_encryption_enabled
  zone_redundant                      = each.value.zone_redundant
  tags                                = each.value.tags

  dynamic "threat_detection_policy" {
    for_each = each.value.threat_detection_policy != null ? { this = each.value.threat_detection_policy } : {}
    content {
      state                      = each.value.threat_detection_policy.value.state
      disabled_alerts            = each.value.threat_detection_policy.value.disabled_alerts
      email_account_admins       = each.value.threat_detection_policy.value.email_account_admins
      email_addresses            = each.value.threat_detection_policy.value.email_addresses
      retention_days             = each.value.threat_detection_policy.value.retention_days
      storage_account_access_key = each.value.threat_detection_policy.value.storage_account_access_key
      storage_endpoint           = each.value.threat_detection_policy.value.storage_endpoint
    }
  }

  dynamic "import" {
    for_each = each.value.import != null ? { this = each.value.import } : {}
    content {
      storage_uri                  = each.value.import.storage_uri
      storage_key                  = each.value.import.storage_key
      storage_key_type             = each.value.import.storage_key_type
      administrator_login          = each.value.import.administrator_login
      administrator_login_password = each.value.import.administrator_login_password
      authentication_type          = each.value.import.authentication_type
      storage_account_id           = each.value.import.storage_account_id
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = each.value.long_term_retention_policy != null ? { this = each.value.long_term_retention_policy } : {}
    content {
      weekly_retention  = each.value.long_term_retention_policy.weekly_retention
      monthly_retention = each.value.long_term_retention_policy.monthly_retention
      yearly_retention  = each.value.long_term_retention_policy.yearly_retention
      week_of_year      = each.value.long_term_retention_policy.week_of_year
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = each.value.short_term_retention_policy != null ? { this = each.value.long_term_retention_policy } : {}
    content {
      retention_days           = each.value.short_term_retention_policy.retention_days
      backup_interval_in_hours = each.value.short_term_retention_policy.backup_interval_in_hours
    }
  }

  lifecycle {
    precondition {
      condition     = each.value.elastic_pool_id == null || each.value.elastic_pool_id != null && each.value.maintenance_configuration_name == null
      error_message = "When creating a database resource with an elastic_pool_id, the maintenance_configuration_name is not supported at the database scope.  Set this on the elastic pool instead."
    }
  }
}
