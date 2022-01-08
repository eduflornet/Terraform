## Tainting resources

in certain situations, you may need to destroy a particular resource in order to rebuild it immediately. Examples of such situations may include modifications that have been made manually on that resource.
To destroy and rebuild a resource, you could perform the terraform **destroy** -target <resource> command, followed by the **apply** command. However, the problem is that between the destroy and apply commands, there may be other changes in the Terraform configuration that will be applied that are not desired.

The goal of this is to destroy and then rebuild the App Service in a single operation using the taint command of Terraform.

## How to do it…
To apply the **taint** operation, perform the following steps:
1. Run the terraform init command to initialize the context.
2. Then, execute the terraform **taint** command to flag the resource as tainted:
```
terraform taint azurerm_app_service.app
```
3. Finally, to rebuild the App Service, execute the following command:
```
terraform apply
```


Finally destroy, run the following commands:
```
terraform destroy 
```

## How it works…
In step 1, we execute the terraform init command to initialize the context. Then, in step 2, we execute the terraform taint command to flag the azurerm_app_service.app resource as tainted; that is, to be destroyed and rebuilt.
Finally, in step 3, we execute the terraform apply command and, when it is executed, we can see that Terraform will delete and then recreate the Azure App Service.

## There's more…
To go further, we can display in the terminal the status of this resource flagged in the Terraform state file by executing the terraform state show command, which displays the contents of the state file in the command terminal [documented here](https://www.terraform.io/cli/commands/state/show) as follows:
```
terraform state show azurerm_app_service.app
```
We can see that the resource App Service has the flag tainted.

*We have used the terraform state command to display the contents of the state, since it is strongly discouraged to read and modify the state file
manually, as [documented here](https://www.terraform.io/language/state#inspection-and-modification)*

*Moreover, in order to cancel the taint flag applied with the terraform taint command, we can execute the inverse command, which is terraform **untaint**. This command can be executed like this:*
```
terraform untaint azurerm_app_service.app
```

  

## References
- [The terraform **taint** command documentation is available here](https://www.terraform.io/cli/commands/taint)
- [The terraform **untaint** command documentation is available here](https://www.terraform.io/cli/commands/untaint)
- [The terraform **state** command documentation is available here](https://www.terraform.io/cli/commands/state/list)
- [An article that explains the taint and untaint commands really well can be
found here](https://www.devopsschool.com/blog/terraform-taint-and-untaint-explained-with-example-programs-and-tutorials/)

 
