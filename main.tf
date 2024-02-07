
# resource "azurerm_private_dns_a_record" "res-7" {
#   name                = "funcapp-rhym-poc-eus2"
#   records             = ["172.16.0.74"]
#   resource_group_name = "rg-thymond-test"
#   tags = {
#     creator = "created by private endpoint funcapp-rhym-poc-eus2-pe with resource guid b5a6675e-e617-4be4-8d5f-181340ffb78a"
#   }
#   ttl       = 10
#   zone_name = "privatelink.azurewebsites.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-6,
#   ]
# }
# resource "azurerm_private_dns_a_record" "res-8" {
#   name                = "funcapp-rhym-poc-eus2.scm"
#   records             = ["172.16.0.74"]
#   resource_group_name = "rg-thymond-test"
#   tags = {
#     creator = "created by private endpoint funcapp-rhym-poc-eus2-pe with resource guid b5a6675e-e617-4be4-8d5f-181340ffb78a"
#   }
#   ttl       = 10
#   zone_name = "privatelink.azurewebsites.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-6,
#   ]
# }
# resource "azurerm_private_dns_a_record" "res-9" {
#   name                = "lapp-rhym-poc-eus2"
#   records             = ["172.16.0.70"]
#   resource_group_name = "rg-thymond-test"
#   tags = {
#     creator = "created by private endpoint lapp-rhym-poc-eus2-pe with resource guid 72ca18f2-252e-40ae-9d6f-40230cc4b0eb"
#   }
#   ttl       = 10
#   zone_name = "privatelink.azurewebsites.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-6,
#   ]
# }
# resource "azurerm_private_dns_a_record" "res-10" {
#   name                = "lapp-rhym-poc-eus2.scm"
#   records             = ["172.16.0.70"]
#   resource_group_name = "rg-thymond-test"
#   tags = {
#     creator = "created by private endpoint lapp-rhym-poc-eus2-pe with resource guid 72ca18f2-252e-40ae-9d6f-40230cc4b0eb"
#   }
#   ttl       = 10
#   zone_name = "privatelink.azurewebsites.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-6,
#   ]
# }
# resource "azurerm_private_dns_zone_virtual_network_link" "res-12" {
#   name                  = "c5evknbd2tpsu"
#   private_dns_zone_name = "privatelink.azurewebsites.net"
#   registration_enabled  = false
#   resource_group_name   = "rg-thymond-test"
#   tags                  = {}
#   virtual_network_id    = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/resourceGroups/rg-thymond-test/providers/Microsoft.Network/virtualNetworks/vnet-rhym-poc-eus2"
#   depends_on = [
#     azurerm_private_dns_zone.res-6,
#     azurerm_virtual_network.res-40,
#   ]
# }


# resource "azurerm_private_dns_a_record" "res-14" {
#   name                = "stofuncprhympoceus2"
#   records             = ["172.16.0.73"]
#   resource_group_name = "rg-thymond-test"
#   tags = {
#     creator = "created by private endpoint stofuncprhympoceus2-blob-pe with resource guid ae261a0d-fa30-414f-97e9-d5a9ad5ca030"
#   }
#   ttl       = 10
#   zone_name = "privatelink.blob.core.windows.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-13,
#   ]
# }
# resource "azurerm_private_dns_a_record" "res-15" {
#   name                = "stolapprhympoceus2"
#   records             = ["172.16.0.69"]
#   resource_group_name = "rg-thymond-test"
#   tags = {
#     creator = "created by private endpoint stolapprhympoceus2-blob-pe with resource guid 0939a183-91fd-4273-bce1-9d842170e9de"
#   }
#   ttl       = 10
#   zone_name = "privatelink.blob.core.windows.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-13,
#   ]
# }
# resource "azurerm_private_dns_zone_virtual_network_link" "res-17" {
#   name                  = "c5evknbd2tpsu"
#   private_dns_zone_name = "privatelink.blob.core.windows.net"
#   registration_enabled  = false
#   resource_group_name   = "rg-thymond-test"
#   tags                  = {}
#   virtual_network_id    = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/resourceGroups/rg-thymond-test/providers/Microsoft.Network/virtualNetworks/vnet-rhym-poc-eus2"
#   depends_on = [
#     azurerm_private_dns_zone.res-13,
#     azurerm_virtual_network.res-40,
#   ]
# }

# resource "azurerm_private_dns_a_record" "res-19" {
#   name                = "stofuncprhympoceus2"
#   records             = ["172.16.0.72"]
#   resource_group_name = "rg-thymond-test"
#   tags = {
#     creator = "created by private endpoint stofuncprhympoceus2-file-pe with resource guid 9685ef1a-97dc-4ecd-9141-576b34a3f0b1"
#   }
#   ttl       = 10
#   zone_name = "privatelink.file.core.windows.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-18,
#   ]
# }
# resource "azurerm_private_dns_a_record" "res-20" {
#   name                = "stolapprhympoceus2"
#   records             = ["172.16.0.68"]
#   resource_group_name = "rg-thymond-test"
#   tags = {
#     creator = "created by private endpoint stolapprhympoceus2-file-pe with resource guid b69f2d0e-a61d-4c90-bbc1-b9c86dcfffee"
#   }
#   ttl       = 10
#   zone_name = "privatelink.file.core.windows.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-18,
#   ]
# }
# resource "azurerm_private_dns_zone_virtual_network_link" "res-22" {
#   name                  = "c5evknbd2tpsu"
#   private_dns_zone_name = "privatelink.file.core.windows.net"
#   registration_enabled  = false
#   resource_group_name   = "rg-thymond-test"
#   tags                  = {}
#   virtual_network_id    = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/resourceGroups/rg-thymond-test/providers/Microsoft.Network/virtualNetworks/vnet-rhym-poc-eus2"
#   depends_on = [
#     azurerm_private_dns_zone.res-18,
#     azurerm_virtual_network.res-40,
#   ]
# }

# resource "azurerm_private_dns_a_record" "res-24" {
#   name                = "kv-rhym-poc-eus2"
#   records             = ["172.16.0.71"]
#   resource_group_name = "rg-thymond-test"
#   tags                = {}
#   ttl                 = 3600
#   zone_name           = "privatelink.vaultcore.azure.net"
#   depends_on = [
#     azurerm_private_dns_zone.res-23,
#   ]
# }
# resource "azurerm_private_dns_zone_virtual_network_link" "res-26" {
#   name                  = "c5evknbd2tpsu"
#   private_dns_zone_name = "privatelink.vaultcore.azure.net"
#   registration_enabled  = false
#   resource_group_name   = "rg-thymond-test"
#   tags                  = {}
#   virtual_network_id    = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/resourceGroups/rg-thymond-test/providers/Microsoft.Network/virtualNetworks/vnet-rhym-poc-eus2"
#   depends_on = [
#     azurerm_private_dns_zone.res-23,
#     azurerm_virtual_network.res-40,
#   ]
# }

# resource "azurerm_servicebus_namespace_authorization_rule" "res-44" {
#   listen       = true
#   manage       = true
#   name         = "RootManageSharedAccessKey"
#   namespace_id = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/resourceGroups/rg-thymond-test/providers/Microsoft.ServiceBus/namespaces/sbn-rhym-poc-eus2"
#   send         = true
#   depends_on = [
#     # One of azurerm_servicebus_namespace.res-43,azurerm_servicebus_namespace_network_rule_set.res-45 (can't auto-resolve as their ids are identical)
#   ]
# }

# resource "azurerm_servicebus_namespace_network_rule_set" "res-45" {
#   default_action                = "Allow"
#   ip_rules                      = []
#   namespace_id                  = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/resourceGroups/rg-thymond-test/providers/Microsoft.ServiceBus/namespaces/sbn-rhym-poc-eus2"
#   public_network_access_enabled = true
#   trusted_services_allowed      = false
#   depends_on = [
#     azurerm_servicebus_namespace.res-43,
#   ]
# }

# resource "azurerm_storage_share" "res-57" {
#   access_tier          = "TransactionOptimized"
#   enabled_protocol     = "SMB"
#   metadata             = {}
#   name                 = "funcapp-rhym-poc-eus29e17"
#   quota                = 5120
#   storage_account_name = "stofuncprhympoceus2"
# }

# resource "azurerm_storage_share" "res-69" {
#   access_tier          = "TransactionOptimized"
#   enabled_protocol     = "SMB"
#   metadata             = {}
#   name                 = "lapp-rhym-poc-eus284e6"
#   quota                = 5120
#   storage_account_name = "stolapprhympoceus2"
# }

# resource "azurerm_api_connection" "res-85" {
#   display_name        = "servicebus-conn"
#   managed_api_id      = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/providers/Microsoft.Web/locations/eastus2/managedApis/servicebus"
#   name                = "servicebus"
#   parameter_values    = {}
#   resource_group_name = "rg-thymond-test"
#   tags                = {}
# }
