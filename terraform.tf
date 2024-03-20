terraform {

  cloud {
    organization = "mikesworld"

    workspaces {
      name = "terraform-assignment8"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }

  required_version = "~> 1.2"
}
