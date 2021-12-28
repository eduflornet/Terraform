## Provisioning infrastructure in multiple environments - Solution 2

Finally, to provision each of these environments, go to the root folder of the Terraform configuration and execute the following commands:

```
  terraform init

  terraform validate

  # DEV
  terraform plan -var-file="dev/terraform.tfvars"

  terraform apply -var-file="dev/terraform.tfvars"

  terraform destroy -var-file="dev/terraform.tfvars"

  # TEST
  terraform plan -var-file="test/terraform.tfvars"

  terraform apply -var-file="test/terraform.tfvars"

  terraform destroy -var-file="test/terraform.tfvars"

  # PRO
  terraform plan -var-file="production/terraform.tfvars"

  terraform apply -var-file="production/terraform.tfvars"

  terraform destroy -var-file="production/terraform.tfvars"
  
  ```

