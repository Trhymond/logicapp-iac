# resource "azurerm_storage_account" "funcapp_storage_account" {
#   name                              = var.funcapp_storage_account_name
#   resource_group_name               = var.resource_group_name
#   location                          = var.location
#   access_tier                       = "Hot"
#   account_kind                      = "StorageV2"
#   account_replication_type          = var.account_replication_type
#   account_tier                      = var.account_tier
#   enable_https_traffic_only         = true
#   infrastructure_encryption_enabled = false
#   min_tls_version                   = "TLS1_2"
#   public_network_access_enabled     = true
#   tags                              = {}

#   network_rules {
#     bypass                     = ["AzureServices"]
#     default_action             = "Allow"
#     ip_rules                   = var.ip_whitelist
#     virtual_network_subnet_ids = [azurerm_subnet.app_snet.id]
#   }

#   routing {
#     choice                      = "MicrosoftRouting"
#     publish_internet_endpoints  = false
#     publish_microsoft_endpoints = true
#   }

#   depends_on = [
#     azurerm_subnet.app_snet,
#     azurerm_resource_group.rg
#   ]
# }

# resource "azurerm_service_plan" "funcapp_plan" {
#   location                     = var.location
#   maximum_elastic_worker_count = 20
#   name                         = var.funcapp_plan_name
#   os_type                      = "Linux"
#   per_site_scaling_enabled     = false
#   resource_group_name          = var.resource_group_name
#   sku_name                     = "EP1"
#   tags                         = {}
#   worker_count                 = 1
#   zone_balancing_enabled       = false

#   depends_on = [azurerm_resource_group.rg]
# }

# resource "azurerm_linux_function_app" "funcapp" {
#   location            = var.location
#   name                = var.funcapp_name
#   resource_group_name = var.resource_group_name

#   service_plan_id            = azurerm_service_plan.funcapp_plan.id
#   storage_account_access_key = azurerm_storage_account.funcapp_storage_account.primary_access_key
#   storage_account_name       = azurerm_storage_account.funcapp_storage_account.name

#   storage_uses_managed_identity = false
#   public_network_access_enabled = true

#   tags = {
#     "hidden-link: /app-insights-resource-id" = azurerm_application_insights.ai.id
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   app_settings = {
#     APPLICATIONINSIGHTS_ENABLE_AGENT = "true"
#   }
#   functions_extension_version     = "~4"
#   https_only                      = true
#   key_vault_reference_identity_id = "SystemAssigned"
#   virtual_network_subnet_id       = azurerm_subnet.app_snet.id

#   site_config {
#     always_on                               = false
#     application_insights_connection_string  = azurerm_application_insights.ai.connection_string
#     container_registry_use_managed_identity = false
#     elastic_instance_minimum                = 1
#     ftps_state                              = "FtpsOnly"
#     http2_enabled                           = true
#     minimum_tls_version                     = "1.2"
#     pre_warmed_instance_count               = 1
#     remote_debugging_enabled                = false
#     worker_count                            = 1

#     application_stack {
#       java_version = "11"
#     }
#     cors {
#       allowed_origins     = ["https://portal.azure.com"]
#       support_credentials = false
#     }
#   }
#   depends_on = [
#     azurerm_subnet.app_snet,
#     azurerm_service_plan.funcapp_plan,
#     azurerm_resource_group.rg
#   ]
# }

# data "azurerm_function_app_host_keys" "funcapp_key" {
#   name                = azurerm_linux_function_app.funcapp.name
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_key_vault_secret" "funcapp_key_secret" {
#   key_vault_id = azurerm_key_vault.kv.id
#   name         = "funcapp-key"
#   tags         = {}
#   value        = data.azurerm_function_app_host_keys.funcapp_key.default_function_key

#   depends_on = [
#     azurerm_key_vault.kv,
#     azurerm_linux_function_app.funcapp
#   ]
# }

# resource "azurerm_private_endpoint" "funcapp_file_pe" {
#   custom_network_interface_name = "${var.funcapp_storage_account_name}-file-pe-nic"
#   location                      = var.location
#   name                          = "${var.funcapp_storage_account_name}-file-pe"
#   resource_group_name           = var.resource_group_name
#   subnet_id                     = azurerm_subnet.private_snet.id
#   tags                          = {}

#   private_dns_zone_group {
#     name                 = "default"
#     private_dns_zone_ids = [azurerm_private_dns_zone.file_dns_zone.id]
#   }

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = "${var.funcapp_storage_account_name}-file-pe"
#     private_connection_resource_id = azurerm_storage_account.funcapp_storage_account.id
#     subresource_names              = ["file"]
#   }

#   depends_on = [
#     azurerm_private_dns_zone.file_dns_zone,
#     azurerm_subnet.private_snet,
#     azurerm_storage_account.funcapp_storage_account
#   ]
# }

# resource "azurerm_private_endpoint" "funcapp_blob_pe" {
#   custom_network_interface_name = "${var.funcapp_storage_account_name}-blob-pe-nic"
#   location                      = var.location
#   name                          = "${var.funcapp_storage_account_name}-blob-pe"
#   resource_group_name           = var.resource_group_name
#   subnet_id                     = azurerm_subnet.private_snet.id
#   tags                          = {}

#   private_dns_zone_group {
#     name                 = "default"
#     private_dns_zone_ids = [azurerm_private_dns_zone.blob_dns_zone]
#   }

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = "${var.funcapp_storage_account_name}-blob-pe"
#     private_connection_resource_id = azurerm_storage_account.funcapp_storage_account.id
#     subresource_names              = ["blob"]
#   }

#   depends_on = [
#     azurerm_private_dns_zone.blob_dns_zone,
#     azurerm_subnet.private_snet,
#     azurerm_storage_account.funcapp_storage_account
#   ]
# }

# resource "azurerm_private_endpoint" "funcapp_pe" {
#   custom_network_interface_name = "${var.funcapp_name}-site-pe-nic"
#   location                      = var.location
#   name                          = "${var.funcapp_name}-site-pe"
#   resource_group_name           = var.resource_group_name
#   subnet_id                     = azurerm_subnet.private_snet.id
#   tags                          = {}

#   private_dns_zone_group {
#     name                 = "default"
#     private_dns_zone_ids = [azurerm_private_dns_zone.site_dns_zone]
#   }

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = "${var.funcapp_name}-site-pe"
#     private_connection_resource_id = azurerm_linux_function_app.funcapp.id
#     subresource_names              = ["sites"]
#   }

#   depends_on = [
#     azurerm_private_dns_zone.site_dns_zone,
#     azurerm_subnet.private_snet,
#     azurerm_linux_function_app.funcapp
#   ]
# }