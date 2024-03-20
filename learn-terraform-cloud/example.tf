<<<<<<< HEAD
# Create a new VPC
resource "aws_vpc" "tf-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tf-vpc"
  }
}

# Create a new Subnet
resource "aws_subnet" "tf-subnet" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-subnet"
  }
}

# Create a new Security Group
resource "aws_security_group" "tf-sg" {
  vpc_id = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "tf-ig" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-ig"
  }
}

# Create a Route Table
resource "aws_route_table" "tf-r" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-ig.id
  }

  tags = {
    Name = "tf-r"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.tf-subnet.id
  route_table_id = aws_route_table.tf-r.id
}

# Create an AWS Key Pair
resource "aws_key_pair" "tf-key" {
  key_name   = "tf-key"
  public_key = file("~/.ssh/id_rsa.pub") 
}

resource "aws_instance" "instance" {
  count = 3
  ami           = "ami-07d9b9ddc6cd8dd30" # Use an appropriate Ubuntu AMI for your region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.tf-key.key_name
  vpc_security_group_ids = [aws_security_group.tf-sg.id]
  subnet_id = aws_subnet.tf-subnet.id
  associate_public_ip_address = true
  user_data = <<-EOF
                #!/bin/bash
                echo "Hello from ${count.index}" > index.html
                nohup busybox httpd -f -p 80 &
                EOF

  tags = {
    Name = "Instance-${count.index}"
  }
}

output "dev" {
  value = aws_instance.instance[0].public_ip
}

output "test" {
  value = aws_instance.instance[1].public_ip
}

output "prod" {
  value = aws_instance.instance[2].public_ip
}
➜  terra cat example.tf 
=======
>>>>>>> 1ccab62 (test1)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "First-one" {
  #ami           = "ami-0c293f3f676ec4f90"
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
}
