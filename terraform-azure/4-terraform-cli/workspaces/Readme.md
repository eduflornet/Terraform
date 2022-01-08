## Using workspaces for managing environments

In Terraform, there is the concept of workspaces, which enables the same Terraform configuration to be used in order to build multiple environments.
Each of these configurations will be written to a different Terraform state file and will thus be isolated from the other configurations. Workspaces can be used to create several environments of our infrastructure.

## How to do it…
To manage a Terraform workspace, perform the following steps:
1. In a new **main.tf** file, we write the following Terraform configuration:
```
resource "azurerm_resource_group" "rg-app" {
name = "RG-APP-${terraform.workspace}"
location = "westeurope"
}
```
2. In a command terminal, we navigate into the folder that contains this Terraform configuration and execute the following command:
```
terraform workspace new dev
```
3. To provision the dev environment, we run the basic commands of the Terraform workflow, which are as follows:
```
> terraform init
> terraform plan -out="outdev.tfplan"
> terraform apply "outdev.tfplan"
```
4. Then, we execute the workspace new command with the name of the production workspace to be created:
```
terraform workspace new prod
```
5. To finish and provision the prod environment, we execute the basic commands of the Terraform workflow production, which are as follows:
```
> terraform init
> terraform plan -out="outprod.tfplan"
> terraform apply "outprod.tfplan"
```

## There's more…
In any Terraform configuration execution, there is a default workspace that only names default.
It is possible to see the list of workspaces in our code by executing the following command:
```
terraform workspace list
```
We can clearly see our **dev** and **prod** workspace, and that the current workspace is prod (marked with an * in front of its name).
If you want to switch to another workspace, execute the terraform workspace select command, followed by the name of the workspace to be selected; for example:
```
terraform workspace select dev
```
Finally, you can also delete a workspace by executing the terraform workspace delete command, followed by the name of the workspace to be deleted; for example:
```
terraform workspace delete dev
```
*Be careful when deleting a workspace that it does not delete the associated resources. That's why, in order to delete a workspace, you must first delete the resources provided by that workspace using the terraform destroy command. Otherwise, if this operation is not carried out, it will no longer be possible to manage these resources with Terraform because the Terraform state file of this workspace will have been deleted.*

In addition, by default, it is not possible to delete a workspace whose state file is not empty.
However, we can force the destruction of this workspace by adding the -force option to the terraform workspace delete -force command, as [documented here](https://www.terraform.io/cli/commands/workspace/delete)

## How it works…
In step 1, in the Terraform configuration we wrote, we provide a Resource Group in Azure that will have a name composed of an RG-APP prefix and a dynamic suffix, terraform.workspace, which will be the name of the workspace we are going to create.
In step 2, we create the workspace that corresponds to the dev environment, and for this we use the terraform workspace new command followed by the workspace name (in this case, dev).
Once created, Terraform is automatically placed in this workspace, After we've created the workspace, we just execute the basic commands of the Terraform workflow, which we do in step 3.
Note that here we have added the -out option to the terraform plan command to save the result of the plan in the outdev.tfplan file. Then, to apply the changes, we specifically add this file as an argument to the terraform apply command.
Then, to provision the prod environment, we repeat exactly the same steps 2 and 3, but this time creating a workspace called prod.
At the end of the execution of all these steps, we can see in the Azure portal that we have our two Resource Groups that contain in the suffix the name of their workspace.

For Destroy, run the following command:
```
terraform destroy 
```

## References
- [The general documentation for workspaces is available here](https://www.terraform.io/language/state/workspaces)
- [The CLI documentation for the terraform workspace command is available here](https://www.terraform.io/language/state/workspaces)
- [Read this blog post for a more complete use of workspaces](https://colinsalmcorner.com/terraform-all-the-things-with-vsts/)

 
