## Using another file inside a custom module

We can have scenarios where we need to use another file in the module that doesn't describe the infrastructure via Terraform (.tf extension), for example, in the case where the module needs to execute a script locally for operating an internal program.
The goal of this is to create a Terraform module that will execute a Bash script that will perform actions on the local computer (for this recipe, a hello world display will suffice).
Since we will be running a Bash script as an example, we will run Terraform under a Linux system.

*It is important to keep in mind that provisioners such as this reduce the reusability of your configuration by assuming that the system where
Terraform runs has Bash installed. This is otherwise usually not a limiting factor in Terraform as it offers builds for different OSes and architectures and runs cross-platform.*

## How to do it…
Perform the following steps to use the file inside the module:
1. In a new folder called execscript (inside the Modules folder) that will contain the code of the module, we create a new file, script.sh, with the following content:

```
echo "Hello world"
```
2. Create a main.tf file in this module and write the following code inside it:
```
resource "null_resource" "execfile" {
provisioner "local-exec" {
command = "${path.module}/script.sh"
interpreter = ["/bin/bash"]
}
}
```
3. Then, in the Terraform configuration, call this module using the following code:
```
module "execfile" {
source = "../Modules/execscript"
}
```
4. Finally, in a command-line terminal, navigate to the folder of the Terraform configuration and execute the basic Terraform workflow with the following commands:
```
terraform init
terraform plan -out="app.tfplan"
terraform apply app.tfplan
```
## How it works…
In steps 1 and 2, we created a module that executes a script locally using the resource, local_exec (https://www.terraform.io/docs/provisioners/local-exec.html). **local_exec** executes a script that is in a script.sh file that is stored inside the module. To configure the path relative to this *script.sh* file, which can be used during the execution of Terraform, we used the path.module expression, which returns the complete path relative to the module.


## References
- [Documentation on the Path.Module expression is available here](https://www.terraform.io/configuration/expressions#references-to-named-values)

