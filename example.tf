# Provider code
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}

provider "aws" { 
  # Configuration options 
}
    
  
resource "aws_instance" "First-one" {
  #ami           = "ami-0c293f3f676ec4f90"
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
}
