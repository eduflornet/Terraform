## Using a private Git repository for sharing a Terraform module
In enterprises, there is a need to create modules without exposing the code of these modules publicly by archiving them in GitHub repositories, which are public, that is, accessible by everyone.
What you need to know is that there are several types of Terraform module sources, as indicated in [this documentation](https://www.terraform.io/language/modules/sources)

As a prerequisite, we need a project that has already been created; it can be named, for example, Terraform-modules, and it will contain the Git repository of all of the modules.

## How to do it…
To use a private module repository, we need to perform the following steps:
1. In the Azure DevOps project, Terraform-modules, create a new Git repository
named terraform-azurerm-webapp with basic configuration
2. In a local workstation, execute the Git command for cloning this repository:
git clone https://eduflormir.visualstudio.com/PoCs/_git/Terraform-Module-Demo
During the first operation, you will have to enter your Azure DevOps login and password for identification
Copy the source code from https://github.com/eduflornet/Terraform/tree/main/terraform-azure/5-modules/moduledemo/Modules/webapp and paste it the
new folder created by the Git clone.
5. Update the content of the Readme.md file with more of a description of the module role.
6. Commit and push all files in this folder; to perform this action, you can use VS Code or Git commands:

```
git add .
git commit -m "add code"
git push origin master
```
7. Add and push a Git tag on this commit with the name, v0.0.1, by executing this command:
```
git tag v1.0.0
git push origin v1.0.0
```
This operation can also be done via the web interface of Azure Repos, in the Tags tab of the repository.

8. Finally, in the Terraform main.tf file, the following code is written that uses the module:
```
resource "azurerm_resource_group" "rg-app" {
    name = "RG_MyAPP_Demo2"
    location = "West Europe"
}
module "webapp" {
source = "git::https://eduflormir.visualstudio.com/PoCs/_git/Terraform-Module-Demo"
    rm-azurerm-webapp?ref=v1.0.0"
    service_plan_name = "spmyapp2"
    app_name = "myappdemobook2"
    location = azurerm_resource_group.rg-app.location
    resource_group_name = azurerm_resource_group.rg-app.name
}
    output "webapp_url" {
    value = module.webapp.webapp_url
}
```

## How it works…
In steps 1 and 2, we created a Git repository in Azure Repos and cloned it locally. Then, in steps 3 to 7, we wrote the Terraform configuration for the module (using an already existing code). We also edited the Readme.md file that will be used as a documentation for the use of the module. Then, we made a commit and pushed this code into the remote Git Azure repository.

And finally, we added a Git tag, which will be in the form vX.X.X and which will be used to version the module.
Finally, in step 8, we wrote the Terraform configuration, which remotely uses this module with a Git type source. For this, we specified the source property of the module with the Git URL of the repository. In addition to this URL, we added the ref parameter to which we give as a value the Git tag we created.
It will be during the execution of the terraform init command that Terraform will clone the repository locally
```
Initializing modules...
Downloading git::https://eduflormir.visualstudio.com/PoCs/_git/Terraform-Module-Demo for webapp...
- webapp in .terraform\modules\webapp

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/azurerm...
- Installing hashicorp/azurerm v2.92.0...
- Installed hashicorp/azurerm v2.92.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!
```

## References
- [We could also very well store the module's code in a GitHub repository and fill the source properties with the GitHub repository URL, as shown in this documentation](https://www.terraform.io/language/modules/sources#github)
- [we took a Git repository in Azure DevOps as an example, but it works very well with other Git repository providers such as Bitbucket here](https://www.terraform.io/language/modules/sources#bitbucket)
- [Regarding Git repository authentication, you can check out this documentation here](https://www.terraform.io/language/modules/sources#generic-git-repository)
- [The module source documentation is available here](https://www.terraform.io/language/modules/sources)



 
