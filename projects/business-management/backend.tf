terraform {
  backend "s3" {
    bucket = "business-management-main-tfstate"
    region = "us-east-1"
    key = "business-management/terraform.tfstate"
    use_lockfile = true
  }
}