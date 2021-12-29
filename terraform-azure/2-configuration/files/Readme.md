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

## References
- [Documentation on the **local_file** resource is available at here](https://www.terraform.io/docs/providers/local/r/file.html)

