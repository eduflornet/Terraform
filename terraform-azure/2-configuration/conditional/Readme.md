## Writing conditional expressions

### How to do it…
In the Terraform configuration of the main.tf file, modify the code of the Resource Group, as follows:
```
resource "azurerm_resource_group" "rg-app" {
name = var.environment == "Production" ? upper(format("RG-%s",var.appname))
: upper(format("RG-%s-%s",var.app-name,var.environment))
location = "westeurope"
}
```
### How it works…
Here, we added the following condition:
```
condition ? true assert : false assert
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
- [Documentation on the various conditions of Terraform can be found here](https://www.terraform.io/configuration/expressions#conditional-expressions)

