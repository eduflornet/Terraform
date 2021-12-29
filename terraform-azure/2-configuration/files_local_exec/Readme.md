## Executing local programs with Terraform
In regarding file manipulation, apart from infrastructure provisioning, Terraform also allows you to run programs or scripts that are located on the local workstation where Terraform has been installed.


## How to do it…
Perform the following steps:
1. In the main.tf file, which is in the files directory of the source code from the previous recipe, complete the Terraform configuration with the following code:

```
resource "null_resource" "readcontentfile" {
provisioner "local-exec" {
command = "Get-Content -Path ../mytextfile.txt"
interpreter = ["PowerShell", "-Command"]
}
}
```
2. Then, in a command-line terminal, execute the Terraform workflow commands, as follows:
```
terraform init
terraform plan -out="app.tfplan"
terraform apply "app.tfplan"
```
## How it works…
I used **null_resource**, which is a null provider resource. This resource doesn't allow us to create resources, but rather run programs locally.
In this resource, we have the provisioner block, which is of the local-exec type, which operates on our local machine. Then, in this block, we indicate the command to execute, which is the -Content command of PowerShell. With this, we are telling Terraform to use the PowerShell interpreter to execute this command.
When executing the respective Terraform commands, we get the following result:

```
null_resource.readcontentfile: Creating...
local_file.myfile: Creating...
null_resource.readcontentfile: Provisioning with 'local-exec'...
null_resource.readcontentfile (local-exec): Executing: ["PowerShell" "-Command" "Get-Content -Path ../mytextfile.txt"]
local_file.myfile: Creation complete after 0s [id=2a29c5a983236a8f5c0fde5c48b7d15a5cb7d47b]
null_resource.readcontentfile (local-exec): This is my text
null_resource.readcontentfile: Creation complete after 1s [id=3648107117806157764]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```
As you can see, the text This is my text, which we had written in the file (in
the **local_file** resource), is displayed in the Terraform runtime output.

## There's more…
I looked at a simple local-exec command being executed with Terraform. It is also possible to execute several commands that are stored in a script file
(Bash, PowerShell, and so on) with a sample Terraform configuration, as shown here:
```
resource "null_resource" "readcontentfile" {
provisioner "local-exec" {
command = "myscript.ps1"
interpreter = ["PowerShell", "-Command"]
}
}
```
The local-exec provisioner sets expectations on the local system, which
may not be obvious. This is usually otherwise mitigated by cross-platform
builds from providers and Terraform itself, where the implementation
should generally work the same on any supported platform
(macOS/Linux/Windows).

In addition, it is important to know that the local-exec provisioner, once executed,
ensures that the Terraform state file cannot be executed a second time by the terraform apply command.
To be able to execute the local-exec command based on a trigger element, such as a resource that has been modified, it is necessary to add a trigger object inside
null_resource that will act as the trigger element of the local-exec resource.
The following example code uses a trigger, based on timestamp, to execute the localexec
code at each execution step of Terraform:
```
resource "null_resource" "readcontentfile" {
triggers = {
trigger = timestamp()
}
provisioner "local-exec" {
command = "Get-Content -Path ../mytextfile.txt"
interpreter = ["PowerShell", "-Command"]
}
}
```

## References
- [The **local-exec** provisioner documentation is available here](https://www.terraform.io/language/resources/provisioners/local-exec)

