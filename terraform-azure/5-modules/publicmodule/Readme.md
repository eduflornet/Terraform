## Using modules from the public registry
To facilitate the development of Terraform configuration, HashiCorp has set up a public Terraform module registry.
This registry actually solves several problems, such as the following:
- Discoverability with search and filter
- The quality provided via a partner verification process
- Clear and efficient versioning strategy, which is otherwise impossible to solve universally across other existing module sources (HTTP, S3, and Git)
These public modules published in this registry are developed by cloud providers, publishers, communities, or even individual users who wish to share their modules publicly.

The purpose of this is to provision a Resource Group and network resources in Azure, which are a Virtual Network and Subnet. We will see the public module call but we won't look at the Terraform configuration of the module in detail.

## How to do it…
To use the Terraform module from a public registry, perform the following steps:
1. In a web browser, go to the URL: [https://registry.terraform.io/browse/modules](https://registry.terraform.io/browse/modules)
2. On this page, in the FILTERS list in the left panel, choose azurerm.
3. In the results list, click on the first result, that is, the Azure / network module
4. Then, on the Details page of this module, copy the code from the Usage section
5. Finally, in your workstation, create a new file, main.tf, then paste the preceding code and update it as follows:

```
resource "azurerm_resource_group" "rg" {
name = "my-rg"
location = "West Europe"
}
module "network" {
source = "Azure/network/azurerm"
resource_group_name = azurerm_resource_group.rg.name
vnet_name = "vnetdemo"
address_space = "10.0.0.0/16"
subnet_prefixes = ["10.0.1.0/24"]
subnet_names = ["subnetdemo"]
}
```


## How it works…
In steps 1 to 2, we explored Terraform's public registry to look for a module that allows the
provisioning of resources for Azure (using the azurerm filter).
Then, in steps 3 and 4, we accessed the Details page of the Network module published by the Azure team.
In step 5, we used this module by specifying these necessary input variables with the source property, which is worth of a public module-specific
alias, Azure/network/azurerm, provided by the registry.

It is possible to use the versioning of these modules by choosing the desired version of the module in the version drop-down list.
And so in the module call, use the Version property with the chosen version number. Note that, like all modules or community packages, you must check that their code is clean and secure before using them by manually reviewing the code inside their GitHub repository. Indeed, in each of these modules, there is a link to the GitHub repository, which contains the sources.

*Also, before using a module in a company project, you must take into account that in case of a request for correction or evolution of a module, you need to create an issue or make a pull request in the GitHub repository of this module. This requires waiting for a period of time (validation waiting time and merge of the pull request) before it can be used with the fixed or the requested evolution. However, it's worth using these modules daily, as they are very handy and save a lot of time for demonstrations, labs, and sandbox projects.*

## References
- [The documentation on the Terraform module registry is available here](https://www.terraform.io/registry)
