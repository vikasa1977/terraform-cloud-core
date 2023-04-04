terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    
  }
  backend "remote" {
        organization = "vikasawate"
        workspaces {
            name = "vikasawate"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
