resource "azurerm_private_dns_zone" "blob_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = {}

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_private_dns_zone" "site_dns_zone" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
  tags                = {}

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_private_dns_zone" "file_dns_zone" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = {}

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_private_dns_zone" "vault_dns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = {}

  depends_on = [azurerm_resource_group.rg]
}