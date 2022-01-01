## Provisioning multiple resources with the count property

In corporate scenarios, there is a need to provide infrastructure and to take into account the
so-called horizontal scalability, that is, N identical resources that will reduce the load on
individual resources (such as compute instances) and the application as a whole.

The challenge we will have to face is as follows:
Writing Terraform configuration that does not require duplicate code for each
instance of identical resources to be provisioned
Being able to rapidly increase or reduce the number of instances of these
resources

## How to do it…
To create multiple identical resources, perform the following steps:
1. In the variables.tf file, we add the following variable:
```
variable "nb_webapp" {
description = "Number of App Service to create"
}
```
2. In the terraform.tfvars file, we give a value for this new variable as follows:
```
nb_webapp = 2
```
3. In the main.tf file, we modify the resource code of azurerm_app_service in the following way:
```
resource "azurerm_app_service" "app" {
count = var.nb_webapp
name = "${var.app_name}-${var.environement}-${count.index+1}"
location = azurerm_resource_group.rg-app.location
resource_group_name = azurerm_resource_group.rg-app.name
app_service_plan_id = azurerm_app_service_plan.plan-app.id
}
```
4. (Optional:) In a new outputs.tf file, we add the output values with the following code:
```
output "app_service_names"{
value = azurerm_app_service.app[*].name
}
```
## How it works…
In step 1, we add an nb_webapp variable, which will contain the number of Azure App Service instances to write, which we then instantiate in step 2 in the terraform.tfvars file.
Then in step 3, in the azurerm_app_service resource, we add the Terraform count property (which is available for all resources and data Terraform blocks) and takes as a value the nb_webapp variable created previously.
Moreover, in the name of the azurerm_app_service resource, we add the suffix with the current index of the count that we increment by 1 (starting from 1, and not from 0, to reflect the fact that count indexes start with zero) with the Terraform instruction count.index +1.
Finally, and optionally, in step 4, we add an output that will contain the names of the App Service instances that have been provisioned.
When executing the terraform plan command of this recipe with the nb_webapp variable equal to 2, we can see that the two App Service instances have been provisioned.


In the same order, run the following commands:
```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 
  
  ```

## References
- [For more information on the **count** property, refer to the documentation here](https://www.terraform.io/language/meta-arguments/count)
 
