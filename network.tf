resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.virtual_network_address_space

  tags = {}

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_subnet" "app_snet" {
  name                                          = "app-snet"
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = true
  resource_group_name                           = var.resource_group_name
  service_endpoints                             = ["Microsoft.AzureActiveDirectory", "Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Web"]
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = var.app_snet_address_space

  delegation {
    name = "Microsoft.Web.serverFarms"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      name    = "Microsoft.Web/serverFarms"
    }
  }

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_subnet" "private_snet" {
  name                                          = "private-snet"
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = true
  resource_group_name                           = var.resource_group_name
  address_prefixes                              = var.pvt_snet_address_space
  service_endpoints                             = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Web"]
  virtual_network_name                          = var.virtual_network_name

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}