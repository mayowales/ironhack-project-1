terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "wale-first-project-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt         = true
    dynamodb_table = "wale-first-prj-table"
  }
}

provider "aws" {
  region = var.aws_region
}
