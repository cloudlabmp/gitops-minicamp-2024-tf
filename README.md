# GitOps with Terraform 2024 Starter Code

## GitHub Actions

- The code in the .github/workflows directory runs the GitHub Actions workflows.
- Amending the terraform.yml file section "# Generates an execution plan for Terraform" to apply/plan will deploy/plan the resources.
- commiting any changes to any of the files in the repo will cause the workflows in the 'workflows' directory to run
- view the workflows in GitHub > Repo > Actions

## CloudFormation - Backend resources

The code in the ./cloudformation directory is optional. 

oidc-role.yml - It is to configure the OIDC role used to authenticate your GitHub Actions workflows to AWS. 
- Copy contents of file into a new stack template in CloudFormation > Infrastructure Composer > Template
- Create a new stack from the template

backend-resources.yml - It is used to create the S3 bucket to host the terraform.tfstate file, and to create the DynamoDB table to host the state lock

- Copy contents of file into a new stack template in CloudFormation > Infrastructure Composer > Template
- Create a new stack from the template

## TF State

- The terraform.tfstate file and state lock locations are defined in the versions.tf file.
- Amend the s3 bucket and DynamoDB table resource names to match those created by CloudFormation

## Terraform - resources

- The code in the ./terraform directory is the starter code for the course.
- The files create the main resources in AWS.
