# resource "azurerm_role_assignment" "logicapp_kv_reader_role" {
#   name                 = "logicapp-kv-reader"
#   role_definition_name = "Key Vault Reader"
#   principal_id         = "e14baf0f-2274-499e-a216-698bd3a4d553"
#   scope                = azurerm_key_vault.kv.id

#   depends_on = [
#     azurerm_key_vault.kv,
#   ]
# }

# resource "azurerm_role_assignment" "sp_kv_sec_officer_role" {
#   name                 = "sp-kv-sec-officer-role"
#   principal_id         = "b3ac31aa-bff0-46fa-bc5f-401228de8a3d"
#   role_definition_name = "Key Vault Secrets Officer"
#   scope                = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/resourceGroups/rg-thymond-test/providers/Microsoft.KeyVault/vaults/kv-rhym-poc-eus2"

#   depends_on = [
#     azurerm_key_vault.kv,
#   ]
# }

# resource "azurerm_role_assignment" "logicapp_sb_receiver" {
#   name                 = "logicapp-sb-receiver"
#   principal_id         = azurerm_servicebus_namespace.svc_bus.identity.0.principal_id
#   role_definition_name = "Azure Service Bus Data Receiver"
#   scope                = azurerm_servicebus_namespace.svc_bus.id
#   depends_on = [
#     azurerm_servicebus_namespace.svc_bus
#   ]
# }