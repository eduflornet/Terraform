## Provisioning infrastructure in multiple environments - Solution 1

Follow these steps to implement the first Terraform configuration folder topology:
1. In an empty folder, create a separate directory per environment: one for dev, one
for test, one for dev, and one for production.
2. Copy the Terraform base configuration into each of these directories identically.
3. Then, in each of these directories, modify the values of the terraform.tfvars
file with the information that is specific to the environment. Here is an extract of
each of these terraform.tfvars files:

```
resource_group_name = "RG-App"
service_plan_name = "Plan-App"
environment = "DEV" #name of the environment to change
```
Finally, to provision each of these environments, inside each of these directories,
execute the classical Terraform execution workflow by running the following commands:

```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 
  
  ```

## References
- [Documentation regarding the -var-file option of the plan and apply commands is available](https://www.terraform.io/docs/commands/plan.html)
- [An article explaining the best practices surrounding Terraform configuration can be found](https://www.terraform-best-practices.com/code-structure)
- [An article explaining the best practices surrounding Terraform configuration can be found](https://www.hashicorp.com/blog/structuring-hashicorp-terraform-configuration-for-production)
