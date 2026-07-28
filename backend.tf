terraform {
  backend "s3" {
    bucket = "terraform-state-backend-bucket-1"
    key    = "terraform/state.tfstate"
    region = "us-east-1"
  }
}