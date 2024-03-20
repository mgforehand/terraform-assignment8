terraform {

  cloud {
    organization = "mikesworld"

    workspaces {
      name = "it3110-bash-stuff-mgforehand"
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
