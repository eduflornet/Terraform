## Exporting the output in JSON

The use of Terraform's outputs that allow you to have output values for the execution of the Terraform configuration. Indeed, we have seen how to declare an output in the Terraform configuration, and we learned that these outputs and their values were displayed at the end of the execution of the terraform apply command.
The advantage of these outputs is that they can be retrieved by a program and thus be used for another operation; for example, in a CI/CD pipeline.

## How to do it…
Perform the following steps to use the output:
1. Execute the Terraform workflow with the following commands:
```
> terraform init
> terraform plan -out="app.tfplan"
> terraform apply "app.tfplan"
```
2. Then, run the terraform output command:
```
terraform output -json
```
3. Finally, to retrieve the URL of the created App Service, we execute the following command in the command terminal:
```
urlwebapp1=$(terraform output -json | jq -r
.app_service_urls.value.webappdemobook1) &&
curl -sL "%{http_code}" -I "$urlwebapp1/hostingstart.html"
```
## How it works…
In step 1, we execute the basic commands of the Terraform workflow. After executing the terraform apply command, the command displays the output.
Then, in step 2, we visualize the output of this Terraform configuration more clearly by executing the terraform output command.

app_service_names: This returns a list of App Service names provided.
app_service_urls: This returns a list of the URLs of provisioned App Services.

Finally, in step 3, we run a script that checks the URL of the webappdemobook1 App Service. In the first line of this script, we execute the terraform output -json command, which enables the result of the output to be returned in JSON format.


Finally destroy, run the following command:
```
  terraform destroy 
  
```
In our case, we could have executed the app_service_urls command to display the value of the output:
```
terraform output app_service_urls
terraform output -json app_service_urls
```

Then, we would run the following command to check the URL:
```
urlwebapp1=$(terraform output app_service_urls -json | jq -r
.webappdemobook1) &&
curl -sL "%{http_code}" -I "$urlwebapp1/hostingstart.html"
We see in this script that the command used is terraform output app_service_urls
-json, which is more simplistic than $(terraform output -json | jq -r
.app_service_urls.value.webappdemobook1).
```

## References
- [The terraform **output** command documentation is available here](https://www.terraform.io/cli/commands/output)
 
