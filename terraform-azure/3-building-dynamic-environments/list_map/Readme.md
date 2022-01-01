## Looping over object collections

Perform the following steps:
1. In the variables.tf file, we add the following Terraform configuration:
```
variable "web_apps" {
description = "List of App Service to create"
type = any
}
```
2. In the terraform.tfvars file, we add the following configuration:
```
web_apps = {
webapp1 = {
"name" = "webappdemobook1"
"location" = "West Europe"
"dotnet_framework_version" = "v4.0"
"serverdatabase_name" = "server1"
},
webapp2 = {
"name" = "webapptestbook2"
"dotnet_framework_version" = "v4.0"
"serverdatabase_name" = "server2"
}
}
```
3. In the main.tf file, we modify the code of the App Service with the following
```
configuration:
resource "azurerm_app_service" "app" {
for_each = var.web_apps
name = each.value["name"]
location = lookup(each.value, "location", "West Europe")
resource_group_name = azurerm_resource_group.rg-app.name
app_service_plan_id = azurerm_app_service_plan.plan-app.id
site_config {
dotnet_framework_version =
each.value["dotnet_framework_version"]
}
connection_string {
name = "DataBase"
type = "SQLServer"
value = "Server=${each.value["serverdatabase_name"]};Integrated
Security=SSPI"
```
4. Finally, in the outputs.tf file, we add the following code:
```
output "app_service_names" {
value = [for app in azurerm_app_service.app : app.name]
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
- [Documentation on loops with for and for_each is available here](https://www.terraform.io/language/meta-arguments/for_each)
- [And the article on these loops can be found at](https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each)
- [The documentation on the lookup function is available](https://www.terraform.io/language/functions/lookup)
 
