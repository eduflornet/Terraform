## Generating passwords with Terraform

When provisioning infrastructure with Terraform, there are some resources that require
passwords in their properties, such as VMs and databases.
To ensure better security by not writing passwords in clear text, you can use a Terraform provider, which allows you to generate passwords.

## How to do it…
Perform the following steps:
1. In the Terraform configuration file for the VM, add the following code:
```
resource "random_password" "password" {
length = 16
special = true
override_special = "_%@"
}
```
2. Then, in the code of the resource itself, modify the password property with the following code:
```
resource "azurerm_virtual_machine" "myterraformvm" {
name = "myVM"
location = "westeurope"
resource_group_name =
azurerm_resource_group.myterraformgroup.name
network_interface_ids =
[azurerm_network_interface.myterraformnic.id]
vm_size = "Standard_DS1_v2"
....
os_profile {
computer_name = "vmdemo"
admin_username = "admin"
admin_password = random_password.password.result
}
....
}
```

## How it works…
In step 1, we added the Terraform random_password resource from the random provider, which allows us to generate strings according to the properties provided. These will be sensitive, meaning that they're protected by Terraform.
Then, in step 2, we used its result (with the result property) in the password property of the VM.

In the same order, run the following commands:
```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 

```

## References
- [To find out more about the random_password resource, read here](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)
- [Documentation regarding sensitive data in Terraform state files is available here](https://www.terraform.io/language/state/sensitive-data)
