## Querying external data with Terraform

Perform the following steps:
1. In the directory that contains our main.tf file, create a PowerShell
GetLocation.ps1 script that contains the following content:
Read the JSON payload from stdin
```
$jsonpayload = [Console]::In.ReadLine()
# Convert JSON to a string
$json = ConvertFrom-Json $jsonpayload
$environment = $json.environment
if($environment -eq "Production"){
$location="westeurope"
}else{
$location="westus"
}
# Write output to stdout
Write-Output "{ ""location"" : ""$location""}"
2. In the main.tf file, add the external block, as follows:
data "external" "getlocation" {
program = ["Powershell.exe", "./GetLocation.ps1"]
query = {
environment = "${var.environment_name}"
}
}
```
3. Then, modify the code of the Resource Group to make its location more dynamic, as follows:
```
resource "azurerm_resource_group" "rg" {
name = "RG-${local.resource_name}"
location = data.external.getlocation.result.location
}
```
4. Optionally, you can add an output value that has the following configuration:
```
output "locationname" {
value = data.external.getlocation.result.location
}
```

## How it works…
In step 1, we wrote the PowerShell GetLocation.ps1 script, which will be called by Terraform locally. This script takes in environment as an input parameter in JSON format.
Then, this PowerShell script makes a condition on this input environment and returns the right Azure region as output so that we can use it in our Terraform configuration.
Then, in step 2, we used the Terraform external resource, which calls this PowerShell script and provides it with the contents of the environment_name variable as a parameter.
Finally, in step 3, we used the return value of this external block in the location property of the Resource Group.

In the same order, run the following commands:
```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 

```

## References
- [For more information about data blocks, take a look at here](https://www.terraform.io/language/data-sources)

