data "azurerm_client_config" "current" {}

variable "rgid" {
  default     = "99991"
  description = "Resource Group ID"
}

variable "create_date" {
  default     = "20190422"
  description = "Used in resource group naming - should be four digit year followed by two-digit month and date - YYYYMMDD or 19991231"
}

variable "environment" {
  default     = "dev"
  description = "Which environment this will create; used to create resource names"
}

variable "location" {
  default     = "southcentralus"
  description = "Location to create all resources"
}

variable "subscription_id" {
  description = "Prompt for subscription ID"
}

variable "tenant_id" {
  description = "Prompt for tenant ID"
}

variable "servicePrincipleId" {
  description = "Service Principle ID for access to key vault"
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}



module "rg" {
  source      = "git::https://github.com/clearesult/cr-azurerm_resource_group.git?ref=v1.0.1"
  rgid        = "${var.rgid}"
  environment = "${var.environment}"
  create_date = "${var.create_date}"
  location    = "${var.location}"
}

module "keyvault" {
  count              = "1"
  source             = "git::https://github.com/clearesult/cr-azurerm_keyvault.git?ref=v1.0.1"
  rg_name            = "${basename(module.rg.id)}"                             # creates inter-module dependency workaround
  rgid               = "${var.rgid}"
  environment        = "${var.environment}"
  location           = "${var.location}"
  servicePrincipleId = "${var.servicePrincipleId}"
  tenant_id          = "${var.tenant_id}"
}
