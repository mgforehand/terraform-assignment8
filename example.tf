terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}

terraform {
  cloud {
    organization = "mikesworld"

    workspaces {
      name = "terraform8-assignment8"
    }
  }
}
# thats in example
