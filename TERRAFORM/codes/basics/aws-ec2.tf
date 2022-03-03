
# provider details. 

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.3.0"
    }
  }
}

provider "aws" {
  # Configuration options
}


# It creates the aws ec2 instance. 

resource "aws_instance" "web" {
  ami           = "ami-0ca05c6eaa4ac40e0"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

output "instance-op" {
    value = aws_instance.web.host_id
  
}
