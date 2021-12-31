## Manipulating local files with Terraform
Terraform is very popular due to its Infrastructure as Code functionality for cloud providers. But it also has many providers that allow us to manipulate the local system.

## How to do it…
Perform the following steps:
1. In a new folder called files, create a main.tf file. Write the following code inside it:
```
resource "local_file" "myfile" {
content = "This is my text"
filename = "../mytextfile.txt"
}
```

2. In a command-line terminal, navigate to the files directory and execute Terraform's workflow commands, which are as follows:
```
terraform init
terraform plan -out="app.tfplan"
terraform apply "app.tfplan"
```
3. In a new archive folder, create a main.tf file and write the following Terraform configuration inside it:
```
data "archive_file" "backup" {
type = "zip"
source_file = "../mytextfile.txt"
output_path = "${path.module}/archives/backup.zip"
}
```
4. Then, using the command-line terminal, navigate to the archive directory and execute the following Terraform commands:
```
terraform init
terraform plan
```
## References
- [Documentation on the **archive_file** resource is available at here](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/archive_file)

