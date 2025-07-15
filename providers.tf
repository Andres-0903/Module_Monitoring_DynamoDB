terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2.0"
    }
  }
  required_version = ">= 1.12.1"
}

provider "aws" {
  region = "us-east-1"
}
