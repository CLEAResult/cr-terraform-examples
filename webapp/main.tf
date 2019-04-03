variable "rgid" {
  default = "99999"
  description = "Resource Group ID"
}

variable "create_date" {
  default = "20190401"
  description = "Used in resource group naming - should be four digit year followed by two-digit month and date - YYYYMMDD or 19991231"
}

variable "environment" {
  default = "dev"
  description = "Which environment this will create; used to create resource names"
}

variable "location" {
  default = "southcentralus"
  description = "Location to create all resources"
}

variable "plan" {
  description = "Azure App Service Plan resource ID (must already exist)"
}

variable "subscription_id" {
  description = "Prompt for subscription ID"
}

variable "tenant_id" {
  description = "Prompt for tenant ID"
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id = "${var.tenant_id}"
}

module "rg" {
  source = "../../resource-group"
  rgid = "${var.rgid}"
  environment = "${var.environment}"
  create_date = "${var.create_date}"
  location = "${var.location}"
}

module "appservice" {
  rg_name = "${basename(module.rg.id)}" # creates inter-module dependency workaround
  rgid = "${var.rgid}"
  environment = "${var.environment}"
  location = "${var.location}"
  count = "1"
  source = "../../appservice"
  plan = "${var.plan}"
}

module "appinsights" {
  count = "1"
  source = "../../appinsights"
  rg_name = "${basename(module.rg.id)}" # creates inter-module dependency workaround
  rgid = "${var.rgid}"
  environment = "${var.environment}"
  location = "${var.location}"
}
