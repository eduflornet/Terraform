## Debugging the Terraform execution

When we execute Terraform commands, the display output of the console is quite simple and clear.
We will study how to activate the debug mode in Terraform, which will allow us to display more information about its execution.
we will use the Terraform configuration [available here](https://github.com/eduflornet/Terraform/tree/main/terraform-azure/4-terraform-cli/sample-app) .

Furthermore, for the purposes of this demonstration, we will run it on a Windows operating system, but the operation is exactly the same on other operating systems.

## How to do it…
To activate the debug on Terraform, perform the following steps:
1. In the PowerShell command-line terminal, execute the following command:
```
$env:TF_LOG = "TRACE"
```
2. Now, we can execute the Terraform workflow commands with display logs activated:
```
> terraform init
> terraform plan -out="app.tfplan"
> terraform apply app.tfplan
```

## How it works…
In step 1, we create a Terraform environment variable, TF_LOG, which enables Terraform's verbose mode to be activated, indicating that we want to see all traces of Terraform's execution displayed.

*we used the **$env** command to set this environment variable because we are working on Windows. You can, of course, do the same on other operating systems with the correct syntax.*

Then, in step 2, we execute the commands of the Terraform workflow and we can see in the output all traces of this execution.

## There's more…
Instead of having all these traces displayed in the console output, it is also possible to save them in a file.

To do this, just create a second environment variable, **TF_LOG_PATH**, like this:
```
$env:TF_LOG_PATH = "./terraform.log"
```
Which will contain as a value the path to the log file. Indeed, the logs are often very verbose and difficult to read on the console output. That's why we prefer that the output of the logs is written in a file that can be read more easily.

Moreover, to disable these traces, the **TF_LOG** environment variable must be emptied by assigning it an empty value as follows:
```
$env:TF_LOG = ""
```


## References
- [The documentation on the Terraform debug is available here](https://www.terraform.io/internals/debugging)
- [Documentation on Terraform's environment variables is available here](https://www.terraform.io/cli/config/environment-variables)



 
