terraform {
  required_version = ">= 0.11.14"
  backend "s3" {
    encrypt = true
    region = "aws_region_code"
    profile = "your_profile_name"
  }
}

