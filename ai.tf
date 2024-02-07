
resource "azurerm_application_insights" "ai" {
  location            = var.location
  name                = var.appinsights_name
  resource_group_name = var.resource_group_name
  application_type    = "web"
  retention_in_days   = 90
  tags                = {}
  workspace_id        = "/subscriptions/9132cd79-25ee-47ba-ab92-d4b83a146b21/resourceGroups/DefaultResourceGroup-EUS2/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-9132cd79-25ee-47ba-ab92-d4b83a146b21-EUS2"

  depends_on = [ azurerm_resource_group.rg ]
}