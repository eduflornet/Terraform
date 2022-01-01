## Using a table of key-value variables with maps
Terraform language has other types of variables such as lists, maps, tuples, and even more complex object variables.
Among these variable types are maps, which are represented by a collection of key-value elements and are widely used to write dynamic and scalable Terraform configurations.
Maps can have several uses, which are as follows:
- To put all the properties of a block in a Terraform resource into a single variable
- To avoid the declaration of several variables of the same type and thus put all the values of these variables in a single variable of the map type
- To have a key-value reference table of elements that will be used in the Terraform configuration

I will illustrate the use of maps in two use cases, which are as follows:
- The implementation of the tags of this Resource Group
- The App settings properties of the App Service

## How to do it…
Perform the following steps:
1. In the variables.tf file, we add the following variable declarations:
```
variable "tags" {
type = map(string)
description = "Tags"
default = {}
}
variable "app_settings" {
type = map(string)
description = "App settings of the App Service"
default = {}
}
```
2. Then, in the terraform.tfvars file, we add this code:
```
tags = {
ENV = "DEV1"
CODE_PROJECT = "DEMO"
}
app_settings = {
KEY1 = "VAL1"
}
```
3. Finally, we modify the main.tf file with the following code:
```
resource "azurerm_resource_group" "rg-app" {
name = "${var.resource_group_name}-${var.environement}"
location = var.location
tags = var.tags
}
resource "azurerm_app_service" "app" {
name = "${var.app_name}-${var.environement}"
location = azurerm_resource_group.rg-app.location
resource_group_name = azurerm_resource_group.rg-app.name
app_service_plan_id = azurerm_app_service_plan.plan-app.id
site_config {
dotnet_framework_version = "v4.0"
}
app_settings = var.app_settings
}
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
- [if we want to use more complex maps with key-values of different types, then we will use object variables, as explained in the documentation here](https://www.terraform.io/language/expressions/type-constraints#object-)
 
