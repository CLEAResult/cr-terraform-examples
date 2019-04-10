provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
  version         = "1.24.0"
}

# OPTIONAL - Set key vault resource name and secret name to retrieve a secret
# Supply the secret to the new database server by:
#
# - Setting the variable key_vault_pw to this data reference
# - Set a variable called use_random_password to false
#
# To use a random password chosen by the cr-azurerm_sql_server module, comment the "data" block below
#
#data "azurerm_key_vault_secret" "admin_password" {
#  name = "${var.secret_name}"
#  vault_uri = "https://${var.vault_name}.vault.azure.net/"
#}

module "rg" {
  source      = "git::ssh://git@github.com/clearesult/cr-azurerm_resource_group.git?ref=v1.0"
  rgid        = "${var.rgid}"
  environment = "${var.environment}"
  create_date = "${var.create_date}"
  location    = "${var.location}"
}

module "sql_server" {
  rg_name             = "${basename(module.rg.id)}"                                                 # creates inter-module dependency
  rgid                = "${var.rgid}"
  environment         = "${var.environment}"
  location            = "${var.location}"
  count               = "1"
  source              = "git::ssh://git@github.com/clearesult/cr-azurerm_sql_server.git?ref=v1.2.0"
  sql_admin_username  = "myadmin"
  use_random_password = true
}

module "db" {
  count       = "1"
  source      = "git::ssh://git@github.com/clearesult/cr-azurerm_sql_database.git?ref=v1.2.1"
  rg_name     = "${basename(module.rg.id)}"                                                   # creates inter-module dependency
  rgid        = "${var.rgid}"
  environment = "${var.environment}"
  location    = "${var.location}"
  server_name = "${module.sql_server.sql_server_name}"                                        # creates inter-module dependency
}
