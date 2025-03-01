terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "gitops-tf-backend-mpcloudlab"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "GitopsTerraformLocks"
  }
}

