## Generating the graph dependencies

One of the interesting features of Terraform is the ability to generate a dependency graph of the resource dependencies mentioned in the Terraform configuration.
we need to use a third-party drawing generation tool called Graphviz, which is available for [download here](https://graphviz.gitlab.io/download/). 
You will need to download and install the package corresponding to your operating system. Moreover, as an example, we will take the Terraform configuration [available here](https://github.com/eduflornet/Terraform/tree/main/terraform-azure/4-terraform-cli/sample-app)

## How to do it…
To generate the graph dependencies, perform the following steps:
1. Execute the terraform graph command:
```
terraform graph | dot -Tsvg > graph.svg
```

2. Open the file explorer and navigate inside the folder that contains the Terraform
configuration and open the file called graph.svg.

## References
- [The terraform graph command documentation is available here](https://www.terraform.io/cli/commands/graph)
- [Documentation relating to Graphviz is available here](https://graphviz.gitlab.io/)
- [An excellent video about the generation of graph dependencies can be found here](https://techsnips.io/snips/how-to-use-graphviz-with-terraform-to-visualize-your-infrastructure/)


 
