resource "azurerm_storage_account" "logicapp_storage_account" {
  location                          = var.location
  name                              = var.logicapp_storage_account_name
  resource_group_name               = var.resource_group_name
  access_tier                       = "Hot"
  account_kind                      = "StorageV2"
  account_replication_type          = var.account_replication_type
  account_tier                      = var.account_tier
  enable_https_traffic_only         = true
  infrastructure_encryption_enabled = false
  min_tls_version                   = "TLS1_2"
  #   public_network_access_enabled     = false


  tags = {}

  network_rules {
    bypass                     = ["AzureServices"]
    default_action             = "Deny"
    ip_rules                   = var.ip_whitelist
    virtual_network_subnet_ids = [azurerm_subnet.app_snet.id]
  }

  depends_on = [
    azurerm_subnet.app_snet,
    azurerm_resource_group.rg
  ]
}

resource "azurerm_storage_share" "logicapp_file_share" {
  name                 = "${var.logicapp_name}-content"
  storage_account_name = azurerm_storage_account.logicapp_storage_account.name
  quota                = 50

  depends_on = [ azurerm_storage_account.logicapp_storage_account ]
}


resource "azurerm_service_plan" "logicapp_plan" {
  location                     = var.location
  maximum_elastic_worker_count = 20
  name                         = var.logicapp_plan_name
  os_type                      = "Windows"
  per_site_scaling_enabled     = false
  resource_group_name          = var.resource_group_name
  sku_name                     = "WS1"
  tags                         = {}
  worker_count                 = 1
  zone_balancing_enabled       = false

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_private_endpoint" "logicapp_file_pe" {
  custom_network_interface_name = "${var.logicapp_storage_account_name}-file-pe-nic"
  location                      = var.location
  name                          = "${var.logicapp_storage_account_name}-file-pe"
  resource_group_name           = var.resource_group_name
  subnet_id                     = azurerm_subnet.private_snet.id
  tags                          = {}

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.file_dns_zone.id]
  }

  private_service_connection {
    is_manual_connection           = false
    name                           = "${var.logicapp_storage_account_name}-file-pe"
    private_connection_resource_id = azurerm_storage_account.logicapp_storage_account.id
    subresource_names              = ["file"]
  }

  depends_on = [
    azurerm_private_dns_zone.file_dns_zone,
    azurerm_subnet.private_snet,
    azurerm_storage_account.logicapp_storage_account
  ]
}

resource "azurerm_private_endpoint" "logicapp_blob_pe" {
  custom_network_interface_name = "${var.logicapp_storage_account_name}-blob-pe-nic"
  location                      = var.location
  name                          = "${var.logicapp_storage_account_name}-blob-pe"
  resource_group_name           = var.resource_group_name
  subnet_id                     = azurerm_subnet.private_snet.id
  tags                          = {}

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob_dns_zone.id]
  }

  private_service_connection {
    is_manual_connection           = false
    name                           = "${var.logicapp_storage_account_name}-blob-pe"
    private_connection_resource_id = azurerm_storage_account.logicapp_storage_account.id
    subresource_names              = ["blob"]
  }

  depends_on = [
    azurerm_private_dns_zone.blob_dns_zone,
    azurerm_subnet.private_snet,
    azurerm_storage_account.logicapp_storage_account
  ]
}


# resource "azurerm_logic_app_standard" "logicapp" {
#   location            = var.location
#   name                = var.logicapp_name
#   resource_group_name = var.resource_group_name
#   app_service_plan_id = azurerm_service_plan.logicapp_plan.id

#   storage_account_access_key = azurerm_storage_account.logicapp_storage_account.primary_access_key
#   storage_account_name       = azurerm_storage_account.logicapp_storage_account.name
#   use_extension_bundle       = true
#   version                    = "~4"

#   identity {
#     type = "SystemAssigned"
#   }

#   app_settings = {
#     APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.ai.connection_string
#     FUNCTIONS_WORKER_RUNTIME              = "node"
#     WEBSITE_NODE_DEFAULT_VERSION          = "~18"
#     WEBSITE_CONTENTOVERVNET = "1"
#   }

#   virtual_network_subnet_id = azurerm_subnet.app_snet.id

#   site_config {
#     vnet_route_all_enabled = true
#     min_tls_version = "1.2"
#     dotnet_framework_version = "v6.0"
#   }


#   depends_on = [
#     azurerm_service_plan.logicapp_plan,
#     azurerm_application_insights.ai,
#     azurerm_resource_group.rg,
#     azurerm_storage_account.logicapp_storage_account
#   ]
# }


resource "azurerm_resource_group_template_deployment" "logicapp-std" {
   name                = var.logicapp_name
   resource_group_name = azurerm_resource_group.rg.name
   deployment_mode = "Incremental"
   parameters_content = jsonencode({
        "logicapp_name" = {
            value = var.logicapp_name 
        },
        "logicapp_plan_id" = { 
            value = azurerm_service_plan.logicapp_plan.id 
        },
        "location" = { 
            value = var.location 
        },
        "subnet_id" = { 
            value = azurerm_subnet.app_snet.id 
        },
        "storage_account_connection_string" = { 
            value = azurerm_storage_account.logicapp_storage_account.primary_connection_string 
        },
        "fileShareName" = { 
            value = "${var.logicapp_name}-content" 
        }
   })

   template_content = <<TEMPLATE
   {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "logicapp_name": {
                "type": "String"
            },
            "logicapp_plan_id": {
                "type": "String"
            },
            "subnet_id": {
                "type": "String"
            },
            "location": {
                "type": "String"
            },
            "storage_account_connection_string": {
                "type": "String"
            },
            "fileShareName": {
               "type": "String"
            }
        },
        "resources": [
            {
                "type": "Microsoft.Web/sites",
                "apiVersion": "2023-01-01",
                "name": "[parameters('logicapp_name')]",
                "location": "[parameters('location')]",
                "kind": "functionapp,workflowapp",
                "identity": {
                    "type": "SystemAssigned"
                },
                "properties": {
                    "serverFarmId": "[parameters('logicapp_plan_id')]",
                    "vnetRouteAllEnabled": true,
                    "vnetContentShareEnabled": true,
                    "siteConfig": {
                        "numberOfWorkers": 1,
                        "alwaysOn": false,
                        "http20Enabled": false,
                        "functionAppScaleLimit": 0,
                        "minimumElasticInstanceCount": 1,
                        "appSettings": [
                            {
                                "name": "FUNCTIONS_EXTENSION_VERSION",
                                "value": "~4"
                            },
                            {
                                "name": "FUNCTIONS_WORKER_RUNTIME",
                                "value": "node"
                            },
                            {
                                "name": "WEBSITE_NODE_DEFAULT_VERSION",
                                "value": "~18"
                            },
                            {
                                "name": "APP_KIND",
                                "value": "workflowApp"
                            },
                            {
                                "name": "WEBSITE_VNET_ROUTE_ALL",
                                "value": "1"
                            },
                            {
                                "name": "AzureFunctionsJobHost__extensionBundle__id",
                                "value": "Microsoft.Azure.Functions.ExtensionBundle.Workflows",
                                "slotSetting": false
                            },
                            {
                                "name": "AzureFunctionsJobHost__extensionBundle__version",
                                "value": "[1.*, 2.0.0)",
                                "slotSetting": false
                            },
                            {
                                "name": "WEBSITE_CONTENTOVERVNET",
                                "value": "1",
                                "slotSetting": false
                            }
                        ]
                    },
                    "httpsOnly": true,
                    "storageAccountRequired": false,
                    "virtualNetworkSubnetId": "[parameters('subnet_id')]",
                    "keyVaultReferenceIdentity": "SystemAssigned"
                }
            }
        ]
   }
TEMPLATE

    depends_on = [  
        azurerm_service_plan.logicapp_plan,
        azurerm_application_insights.ai,
        azurerm_resource_group.rg,
        azurerm_storage_account.logicapp_storage_account,
        azurerm_storage_share.logicapp_file_share
    ]
}