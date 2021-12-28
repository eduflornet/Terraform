## Obtaining external data with Terraform data sources

Perform the following steps:
1. In our file that contains our Terraform configuration, add the following data block:
```
data "azurerm_app_service_plan" "myplan" {
name = "app-service-plan"
resource_group_name = "rg-service_plan"
}

```
In the properties sections, specify the name and the Resource Group of the Service Plan to be used.
2. Then, complete the existing App Service configuration, as follows:
```
resource "azurerm_app_service" "app" {
name = "${var.app_name}-${var.environement}"
location = azurerm_resource_group.rg-app.location
resource_group_name = azurerm_resource_group.rg-app.name
app_service_plan_id = data.azurerm_app_service_plan.myplan.id
}
```

## How it works…
In step 1, a data block is added to query existing resources. In this data block, we specify the Resource Group and the name of the existing Service Plan.
In step 2, we use the ID of the Service Plan that was retrieved by the data block we added in
step 1.

In the same order, run the following commands:
```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 
  
  ```

## References
- [For more information about data blocks, take a look at here](https://www.terraform.io/language/data-sources)

