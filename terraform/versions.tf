terraform {
  backend "s3" {
    bucket = "gitops-tf-backend-mpcloudlab"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "GitopsTerraformLocks"
  }
}
