## Creating a Terraform module and using it locally

A Terraform module is a Terraform configuration that contains one or more Terraform resource. Once created, this module can be used in several Terraform configuration files either locally or even remotely.

## How to do it…
To create the module, perform the following steps:
1. In a new folder called moduledemo, create the Modules and webapp folders.
2. In the webapp folder, create a new variables.tf file with the following code:
```
variable "resource_group_name" {
description = "Resource group name"
}
variable "location" {
description = "Location of Azure resource"
default = "West Europe"
}
variable "service_plan_name" {
description = "Service plan name"
}
variable "app_name" {
description = "Name of application"
}
```
3. Then, create the main.tf file with the following code:
```
resource "azurerm_app_service_plan" "plan-app" {
name = var.service_plan_name
location = var.location
resource_group_name = var.resource_group_name
sku {
tier = "Standard"
size = "S1"
}
}
resource "azurerm_app_service" "app" {
name = var.app_name
location = var.location
resource_group_name = var.resource_group_name
app_service_plan_id = azurerm_app_service_plan.plan-app.id
app_settings = {
"INSTRUMENTATIONKEY" = azurerm_application_insights.appinsightapp.
instrumentation_key
}
}
resource "azurerm_application_insights" "appinsight-app" {
name = var.app_name
location = var.location
resource_group_name = var.resource_group_name
application_type = "web"
}
```
4. Finally, create the output.tf file with the following code:
```
output "webapp_id" {
value = azurerm_app_service.app.id
}
output "webapp_url" {
value = azurerm_app_service.app.default_site_hostname
}
```
5. Inside the moduledemo folder, create a subfolder called MyApp.
6. Inside the MyApp folder, create a main.tf file with the following code:
```
resource "azurerm_resource_group" "rg-app" {
name = "RG_MyAPP_demo"
location = "West Europe"
}
module "webapp" {
source = "../Modules/webapp"
service_plan_name = "spmyapp"
app_name = "myappdemo"
location = azurerm_resource_group.rg-app.location
resource_group_name = azurerm_resource_group.rg-app.name
}
output "webapp_url" {
value = module.webapp.webapp_url
}
```
## How it works…
In step 1, we create the moduledemo directory, which will contain the code for all modules with one subdirectory per module. So, we create a WebApp subdirectory for our recipe, which will contain the Terraform configuration of the webapp module. Then in steps 2, 3, and 4, we create the module code, which is the standard Terraform configuration and contains the following files:
main.tf: This file contains the code of the resources that will be provided by the module. variables.tf: This file contains the input variables needed by the module. 
outputs.tf: This file contains the outputs of the module that can be used in the main Terraform configuration.
In step 5, we created the directory that will contain the Terraform configuration of our application. Finally, in step 6, we created the Terraform configuration of our application with the main.tf file.

In the code of this file, we have three Terraform elements: There is the Terraform azurerm_resource_group resource, which provides a
Resource Group.
The Terraform configuration that uses the module we created, using the module "<module name>" expression. In this module type block, we used the source
properties whose value is the relative path of the directory that contains the webapp module.

*Note that if some variables of the module are defined with default values, then in some cases, it will not be necessary to instantiate them when calling the module.*

We also have the Terraform output, webapp_url, which gets the output of the module to use it as output for our main Terraform configuration.


To apply this Terraform configuration, you have to navigate in a command terminal to the **MyApp** folder containing the Terraform configuration and then execute the following Terraform workflow commands:
```
  terraform init
  terraform plan -out="app.tfplan"
  terraform apply app.tfplan 
  
  terraform destroy 
```
When executing the terraform init command, Terraform will get the module's code and hence integrate its configuration with that of the application
Finally, at the end of the execution of the terraform apply command, the value of the output is displayed in the terminal.
Our Terraform configuration has therefore retrieved the output of the module and used it as the output of our main code.


## References
- [The documentation on module creation is available here](https://www.terraform.io/language/modules/develop)
- [General documentation on the modules is available here](https://www.terraform.io/language/modules/syntax)
- [Terraform's learning lab on module creation is available here](https://learn.hashicorp.com/tutorials/terraform/module-create)
