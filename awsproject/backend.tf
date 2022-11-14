# Configure the AWS provider
terraform {
  required_version = ">=0.12.6"
  backend "s3" {
   bucket         = "pilotinfra"
   key            = "dev/terraform.tfstate"
   region         = "us-east-1"
  # profile = "foxconn"
  }
}
