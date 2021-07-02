## Add terraform to the PATH
TO DO: Add a Makefile to automate below steps
1. Download terraform cli: https://www.terraform.io/downloads.html
2. Unzip and copy terraform binary file to ./terraform/bin
3. Add terraform to PATH:
    export PATH=<pwd>/terraform/bin:$PATH

## Deploying to AWS
1. terraform init
2. Check changes 
    terraform plan
3. Deploy to AWS
    terraform apply

## Deleting AWS resources
1. terraform plan -destroy -out destroy.plan
2. terraform apply destroy.plan