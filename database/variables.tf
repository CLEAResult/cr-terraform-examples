variable "rgid" {
  default     = "99998"
  description = "Resource Group ID"
}

variable "create_date" {
  default     = "20190401"
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

variable "sql_admin_username" {
  description = "The administrator username of the SQL Server."
}

variable "use_random_password" {
  default     = true
  description = "Default is true. If true, deploy the Azure SQL server with a randomly created password that will be visible in the state.  If false, you must have a valid vault_name and secret_name variable entered, which will supply the password."
}

variable "vault_name" {
  default     = ""
  description = "Name of an Azure Key Vault.  The system or usrename running Terraform must be able to authenticate to this vault with get/list secrets permissions."
}

variable "secret_name" {
  default     = ""
  description = "Name of secret in the vault specified by var.vault_name that contains the sql administrator password."
}

variable "key_vault_pw" {
  default     = ""
  description = "Pass in a custom password, such as an Azure Key Vault data reference."
}
