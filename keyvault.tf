# resource "azurerm_key_vault" "kv" {
#   location                        = var.location
#   name                            = var.keyvault_name
#   public_network_access_enabled   = true
#   purge_protection_enabled        = false
#   resource_group_name             = var.resource_group_name
#   sku_name                        = var.keyvault_sku_name
#   soft_delete_retention_days      = 90
#   enable_rbac_authorization       = true
#   enabled_for_deployment          = false
#   enabled_for_disk_encryption     = false
#   enabled_for_template_deployment = false
#   access_policy                   = []

#   tags      = {}
#   tenant_id = data.azurerm_client_config.current.tenant_id

#   network_acls {
#     bypass                     = "AzureServices"
#     default_action             = "Deny"
#     ip_rules                   = var.ip_whitelist
#     virtual_network_subnet_ids = [azurerm_subnet.app_snet]
#   }

#   depends_on = [
#     azurerm_subnet.app_snet,
#     azurerm_resource_group.rg
#   ]
# }

# resource "azurerm_private_endpoint" "kv_pe" {
#   custom_network_interface_name = "${var.keyvault_name}-vault-pe-nic"
#   location                      = var.location
#   name                          = "${var.keyvault_name}-vault-pe"
#   resource_group_name           = var.resource_group_name
#   subnet_id                     = azurerm_subnet.private_snet.id
#   tags                          = {}

#   private_dns_zone_group {
#     name                 = "default"
#     private_dns_zone_ids = [azurerm_private_dns_zone.vault_dns_zone]
#   }

#   private_service_connection {
#     is_manual_connection           = false
#     name                           = "${var.keyvault_name}-vault-pe"
#     private_connection_resource_id = azurerm_key_vault.kv.id
#     subresource_names              = ["vault"]
#   }

#   depends_on = [
#     azurerm_private_dns_zone.vault_dns_zone,
#     azurerm_subnet.private_snet,
#     azurerm_key_vault.kv
#   ]
# }
