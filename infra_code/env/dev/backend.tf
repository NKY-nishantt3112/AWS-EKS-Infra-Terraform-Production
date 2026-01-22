terraform {
  backend "s3" {
    bucket         = "0948-eks-prod-infra-terraform-bucket"
    key            = "dev/dev.tfstate"
    dynamodb_table = "terraform-eks-demo-lock"

  }
}