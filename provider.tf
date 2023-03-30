terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    
  }
  backend "remote" {
        organization = "hecta"
        workspaces {
            name = "cli-driven"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
