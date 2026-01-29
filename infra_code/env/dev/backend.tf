terraform {
  backend "s3" {
    bucket         = "2387-dev-infra-tfstate-s3-bucket"
    key            = "dev/dev.tfstate"
    dynamodb_table = "Nishnat-EKS-dev-infra"
    region         = "ap-south-1"
  }
}