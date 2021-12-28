## Using external resources from other state files

Perform the following steps:
1. In the Terraform configuration that provides the Azure App Service, add and configure the terraform_remote_state block, as follows:
```
data "terraform_remote_state" "service_plan_tfstate" {
backend = "azurerm"
config = {
resource_group_name = "rg_tfstate"
storage_account_name = "storstate"
container_name = "tfbackends"
key = "serviceplan.tfstate"
}
}
```
1. Then, in the Terraform configuration of the Azure App Service, use the created output of the Service Plan, as follows:
```
resource "azurerm_app_service" "app" {
name = "${var.app_name}-${var.environement}"
location = azurerm_resource_group.rg-app.location
resource_group_name = azurerm_resource_group.rg-app.name
app_service_plan_id =
data.terraform_remote_state.service_plan_tfstate.service_plan_id
}
```

## How it works…
In step 1, we added the terraform_remote_state block, which allows us to retrieve outputs present in another Terraform state file. In its block, we specified the remote backend information, which is where the given Terraform state is stored (in this recipe, we
used Azure Storage). In step 2, we used the ID returned by the output present in the Terraform state file.

## There's more…
This technique is very practical when separating the Terraform configuration that deploys a complex infrastructure.
Separating the Terraform configuration is a good practice because it allows better control and maintainability of the Terraform configuration. It also allows us to provision each part separately, without it impacting the rest of the infrastructure.
To know when to use a data block or a terraform_remote_state block, the following recommendations must be kept in mind:
The data block is used in the following cases:
When external resources have not been provisioned with
Terraform configuration (it has been built manually or with a script)
When the user providing the resources of our Terraform
configuration does not have access to another remote backend
The terraform_remote_state block is used in the following cases:
External resources have not been provisioned with Terraform
configuration
When the user providing the resources of our Terraform
configuration has read access to the other remote backend
When the external Terraform state file contains the output of the
property we need in our Terraform configuration

In the same order, run the following commands:
```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 

```

## References
- [The documentation for the terraform_remote_state block is available here](https://www.terraform.io/language/state/remote-state-data)



