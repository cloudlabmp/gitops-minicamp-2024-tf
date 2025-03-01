# GitOps with Terraform 2024

## GitHub Actions

- The code in the `.github/workflows` directory runs the GitHub Actions workflows.
- The `plan.yml` file now includes Open Policy Agent (OPA) validation to enforce allowed AWS instance types.
- The `tflint.yml` workflow ensures Terraform code follows best practices and fails on warnings.
- Terraform plans are automatically generated and validated before deployment.
- Commits to any file in the repository trigger workflows in the `workflows` directory.
- View the workflows in **GitHub > Repo > Actions**.

## CloudFormation - Backend Resources

The code in the `cfn` directory is optional and helps set up the Terraform backend.

- **`oidc-role.yml`**: Configures the OIDC role used to authenticate GitHub Actions workflows with AWS.
  - Copy contents into a new stack template in **CloudFormation > Infrastructure Composer > Template**.
  - Create a new stack from the template. 
  [Click to Deploy OIDC Role](https://console.aws.amazon.com/cloudformation/home?region=eu-west-2#/stacks/create/review?templateURL=https://gitops-cf-templates-mpcloudlab.s3.eu-west-2.amazonaws.com/template-oidc-role.yaml)

- **`backend-resources.yml`**: Creates the S3 bucket to host the Terraform state (`terraform.tfstate`) and a DynamoDB table for state locking.
  - Copy contents into a new stack template in **CloudFormation > Infrastructure Composer > Template**.
  - Create a new stack from the template.
  [Click to Deploy Backend Resources](https://console.aws.amazon.com/cloudformation/home?region=eu-west-2#/stacks/create/review?templateURL=https://gitops-cf-templates-mpcloudlab.s3.eu-west-2.amazonaws.com/template-backend-resources.yaml)

## Terraform State

- The Terraform state file and lock locations are defined in `versions.tf`.
- **Important Update**: The `versions.tf` file has been corrected to ensure only one `terraform` block is present.
- The S3 bucket and DynamoDB table names in `versions.tf` should match those created by CloudFormation.

## Terraform - Resources

- The code in the `terraform` directory defines AWS resources.
- **Updates Implemented:**
  - The `variables.tf` file has been updated to explicitly define variable types (`region` and `instance_type`).
  - `instance-type.rego` in the `policies` directory ensures only allowed EC2 instance types (`t3.micro`, `t3.small`) are deployed.
  - The `plan.json` file now includes multiple resources, including an **Internet Gateway (`aws_internet_gateway.gitops_igw`)**.
  - The `Run OPA Tests` step now correctly references the policy path and is integrated into `plan.yml`.
  - GitHub CLI (`gh`) is configured with `GH_TOKEN` to allow commenting on PRs when OPA tests fail.

## Policies - OPA Security Rules

- The `policies` directory contains Open Policy Agent (OPA) policies for Terraform validation.
- **`instance-policy.rego`**: Validates EC2 instance types against the allowed list.
- **`cost.rego`**: (Placeholder for additional cost enforcement rules in the future.)

## How to Use

1. **Setup Terraform Backend** (Optional)
   - Deploy `backend-resources.yml` to create the necessary S3 bucket and DynamoDB table.
2. **Run Terraform Locally**
   - Navigate to the `terraform` directory.
   - Initialize Terraform:
     ```sh
     terraform init
     ```
   - Validate the configuration:
     ```sh
     terraform validate
     ```
   - Generate and review a plan:
     ```sh
     terraform plan
     ```
   - Apply the configuration:
     ```sh
     terraform apply
     ```
3. **Automated Checks via GitHub Actions**
   - Push any changes to trigger Terraform validation and security checks.
   - Failed OPA tests will block PRs and comment on GitHub with the failure reason.
   - `tflint` ensures best practices are followed before Terraform execution.

## Notes

- Ensure AWS credentials are configured correctly for GitHub Actions to deploy resources.
- The `install terraform.txt` file can be used for setting up Terraform dependencies locally.
- Use **GitHub Actions** to enforce policy compliance and ensure secure Terraform deployment.

---
This README reflects the latest updates and workflow improvements in this project. 🚀

