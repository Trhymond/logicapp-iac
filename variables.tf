variable "location" {
  type    = string
  default = "eastus2"
}

variable "resource_group_name" {
  type    = string
  default = "rg-thymond-test"
}

variable "appinsights_name" {
  type    = string
  default = "ai-thymond-poc-eus2"
}

# variable "keyvault_name" {
#   type    = string
#   default = "kv-rhym-poc-eus2"
# }

# variable "keyvault_sku_name" {
#   type    = string
#   default = "standard"
# }

variable "virtual_network_name" {
  type    = string
  default = "vnet-rhym-poc-eus2"
}

variable "virtual_network_address_space" {
  type    = list(string)
  default = ["172.16.0.0/24"]
}

variable "app_snet_address_space" {
  type    = list(string)
  default = ["172.16.0.0/26"]
}

variable "pvt_snet_address_space" {
  type    = list(string)
  default = ["172.16.0.64/26"]
}

# variable "servicebus_namespace" {
#   type    = string
#   default = "sbn-rhym-poc-eus2"
# }

# variable "servicebus_sku" {
#   type    = string
#   default = "Standard"
# }

variable "logicapp_storage_account_name" {
  type    = string
  default = "stolapprhympoceus2"
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "ip_whitelist" {
  type    = list(string)
  default = ["107.11.39.5"]
}

variable "logicapp_name" {
  type    = string
  default = "lapp4-rhym-poc-eus2"
}

variable "logicapp_plan_name" {
  type    = string
  default = "lapp-plan-rhym-poc-eus2"
}


# variable "funcapp_storage_account_name" {
#   type    = string
#   default = "stofuncprhympoceus2"
# }

# variable "funcapp_name" {
#   type    = string
#   default = "funcapp-rhym-poc-eus2"
# }
# variable "funcapp_plan_name" {
#   type    = string
#   default = "funcapp-plan-rhym-poc-eus2"
# }