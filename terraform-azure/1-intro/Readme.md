## Terraform Intro on Azure

In the same order, run the following commands:

```
  terraform init

  terraform validate
  
  terraform plan -var resource_group_name=myrgterraform -var resource_location="westeurope" -var storage_account_name=mysaterraform

  terraform apply -var resource_group_name=myrgterraform -var resource_location="westeurope" -var storage_account_name=mysaterraform

  terraform destroy -var resource_group_name=myrgterraform -var resource_location="westeurope" -var storage_account_name=mysaterraform
  
  ```

## References
- [For more information about the properties of the Terraform block](https://www.terraform.io/docs/configuration/terraform.html)
- [For more information about the properties of the providers](https://www.terraform.io/docs/configuration/terraform.html)
- [More information about Terraform binary versioning is documented](https://www.terraform.io/docs/extend/best-practices/versioning.html)
