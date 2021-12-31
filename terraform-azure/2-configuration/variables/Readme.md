## Manipulating variables
When you write a Terraform configuration file where all the properties are hardcoded in the code, you often find yourself faced with the problem of having to duplicate it in order to reuse it.

## How to do it…
Perform the following steps:
1. In the same main.tf file, add the following variable declarations:
```
variable "resource_group_name" {
description ="The name of the resource group"
}
variable "location" {
description ="The name of the Azure location"
default ="West Europe"
}
```
2. Then, modify the Terraform configuration we had at the beginning of this recipe
```
so that it refers to our new variables, as follows:
resource "azurerm_resource_group" "rg" {
name = var.resource_group_name
location = var.location
}
```
3. Finally, in the same folder that contains the main.tf file, create a new file called terraform.tfvars and add the following content:
```
resource_group_name = "My-RG"
location = "westeurope"
```

In the same order, run the following commands:
```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 
  
  ```

## References
- [For more information on variables, refer to the documentation here](https://www.terraform.io/docs/configuration/variables.html)
 
