# resource "azurerm_servicebus_namespace" "svc_bus" {
#   location                      = var.location
#   minimum_tls_version           = "1.2"
#   name                          = var.servicebus_namespace
#   public_network_access_enabled = true
#   resource_group_name           = var.resource_group_name
#   sku                           = var.servicebus_sku
#   tags                          = {}
#   zone_redundant                = false
#   local_auth_enabled            = true

#   network_rule_set {
#     default_action                = "Allow"
#     ip_rules                      = []
#     public_network_access_enabled = true
#     trusted_services_allowed      = false
#   }

#   depends_on = [azurerm_resource_group.rg]
# }

# resource "azurerm_servicebus_topic" "svc_bus_topic" {
#   auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
#   default_message_ttl                     = "P14D"
#   duplicate_detection_history_time_window = "PT10M"
#   enable_batched_operations               = true
#   enable_express                          = false
#   enable_partitioning                     = false
#   max_message_size_in_kilobytes           = 256
#   max_size_in_megabytes                   = 1024
#   name                                    = "test-topic"
#   namespace_id                            = azurerm_servicebus_namespace.svc_bus.id
#   requires_duplicate_detection            = false
#   support_ordering                        = false
#   depends_on = [
#     azurerm_servicebus_namespace.svc_bus
#   ]
# }

# resource "azurerm_servicebus_subscription" "svc_bus_topic_subs" {
#   auto_delete_on_idle                       = "P14D"
#   client_scoped_subscription_enabled        = false
#   dead_lettering_on_filter_evaluation_error = false
#   dead_lettering_on_message_expiration      = false
#   default_message_ttl                       = "P14D"
#   enable_batched_operations                 = true
#   lock_duration                             = "PT1M"
#   max_delivery_count                        = 10
#   name                                      = "test-topic-subscription"
#   requires_session                          = false
#   topic_id                                  = azurerm_servicebus_topic.svc_bus_topic.id
#   depends_on = [
#     azurerm_servicebus_topic.svc_bus_topic
#   ]
# }