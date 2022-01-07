## Importing existing resources

In certain scenarios, however, it may be necessary to import resources that have already been provisioned into the Terraform state file. Examples of such scenarios include the following:
Resources have been provisioned manually (or by scripts) and now it is desired that their configuration is in the Terraform configuration and in the state file.
A Terraform state file that contains the configuration of an infrastructure has been corrupted or deleted and regeneration is desirable. With the assistance of Terraform commands, we can import the configuration of resources that have already been provisioned into the Terraform state file.

We will use the following Terraform configuration, which we have already written, in order to provision a Resource Group:
```
resource "azurerm_resource_group" "rg-app" {
name = "RG-APP-IMPORT"
location = "westeurope"
}
```
In the Azure portal, we have created this Resource Group called RG-APP-IMPORT manually, as explained in the pertinent [documentation here](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal).

At this point, if we run Terraform on this code, the terraform apply command will try to create this Resource Group. It will fail and return the error that the Resource Group already exists and cannot be created.

The goal of this is to import the configuration of this Resource Group in the Terraform state file corresponding to our Terraform configuration.

## How to do it…
Perform the following steps:
1. We initialize the Terraform context by executing the init command:
```
terraform init
```
2. Then, we execute the terraform import command as follows:
```
terraform import azurerm_resource_group.rg-app/subscriptions 3ad9e185-e8f4-4ca8-90f2-433659ced319/resourceGroups/RG-APP-IMPORT
```


Finally, In the same order, run the following commands:
```
  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 
  
  ```

## References
- [The documentation pertaining to the **import** command is available here](https://www.terraform.io/cli/commands/import)
 
