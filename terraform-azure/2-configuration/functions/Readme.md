## Calling Terraform built-in functions

When provisioning infrastructure or handling resources with Terraform, it is sometimes
necessary to use transformations or combinations of elements provided in the Terraform
configuration.
For this purpose, the language supplied with Terraform (HCL2) includes functions that are
built-in and can be used in any Terraform configuration.

## How to do it…
Perform the following steps:
1. In a new local folder, create a file called main.tf.
2. In this main.tf file, write the following code:
```
variable "app_name" {
description = "Name of application"
}
variable "environement" {
description = "Environement Name"
}
```
3. Finally, in this main.tf file, write the following Terraform configuration:
```
resource "azurerm_resource_group" "rg-app" {
name = upper(format("RG-%s-%s",var.appname,
var.environement))
location = "westeurope"
}
```

## How it works…
In step 3, we defined the property name of the resource with a Terraform format function,
which allows us to format text. In this function, we used the %s verb to indicate that it is a character string that will be replaced, in order, by the name of the application and the name
of the environment.
Furthermore, to capitalize everything inside, we encapsulate the format function in the upper function, which capitalizes all its contents.

Thus, thanks to these functions, it is possible to control the properties that will be used in the Terraform configuration. This also allows us to apply transformations automatically,
without having to impose constraints on the user using the Terraform configuration.

In the same order, run the following commands:
```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 
  
  ```

## References
- [There are a multitude of predefined functions in Terraform. The full list can be found here](https://www.terraform.io/language/functions)

