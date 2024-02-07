terraform {
  required_version = ">= 1.6.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.82.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "1.12.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    template_deployment {
      delete_nested_items_during_deletion = false
    }
  }
}

provider "azapi" {
}

