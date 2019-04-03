# tf-examples

Example files using the public CR Terraform modules.

# webapp

Creates:

* a new resource group
* an azure web app on an existing app service plan
* an application insights instance

# Common Requirements

* An Azure tenant and subscription ID
* Already authenticated to azure - See https://www.terraform.io/docs/providers/azurerm/index.html#authenticating-to-azure for more info

# **CAUTION**

Always run `terraform plan` before `terraform apply`!

Make sure you know where this will be created before creating.

# Usage

```
terraform init
terraform plan
terraform apply
terraform destroy
```
