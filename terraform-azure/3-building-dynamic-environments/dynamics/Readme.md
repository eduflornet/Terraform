## Generating multiple blocks with dynamic expressions

To use dynamic expressions, perform the following steps:
1. In the variables.tf file, we add the following code:
```
variable "ngs_rules" {
description = "List of NSG rules"
type = any
}
```
2. In the terraform.tfvars file, we add the following code:
```
ngs_rules = [
{
name = "rule1"
priority = 100
direction = "Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range = "80"
source_address_prefix = "*"
destination_address_prefix = "*"
},
{
name = "rule"
priority = 110
direction = "Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range = "22"
source_address_prefix = "*"
destination_address_prefix = "*"
}
]
```
3. In the main.tf file, we add the code for the Network Security Group with the following code:
```
resource "azurerm_network_security_group" "example" {
name = "acceptanceTestSecurityGroup1"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
dynamic "security_rule" {
for_each = var.ngs_rules
content {
name = security_rule.value["name"]
priority = security_rule.value["priority"]
direction = security_rule.value["direction"]
access = security_rule.value["access"]
protocol = security_rule.value["protocol"]
source_port_range = security_rule.value["source_port_range"]
destination_port_range =
security_rule.value["destination_port_range"]
source_address_prefix =
security_rule.value["source_address_prefix"]
destination_address_prefix =
security_rule.value["destination_address_prefix"]
}
}
}
```

In the same order, run the following commands:
```
  terraform init

  terraform validate
  
  terraform plan 

  terraform apply 

  terraform destroy 
  
  ```

## References
- [Documentation on dynamic expressions is available here](https://www.terraform.io/configuration/expressions#dynamic-blocks)
- [Another example of a Terraform guide on dynamic expressions is available here](https://github.com/hashicorp/terraform-guides/tree/master/infrastructure-as-code/terraform-0.12-examples/advanced-dynamic-blocks)

 
