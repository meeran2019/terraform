
# It creates the aws ec2 instance. 
resource "aws_instance" "web" {
  ami           = var.ami-value
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }    
}

# Variables can be in separate file or in under same file. 
variable "ami-value" {
    default = "ami-0ca05c6eaa4ac40e0"
}

terraform {
  backend "s3" {
      bucket = "aws-s3-bucket-terraform-2022"
      region = "us-west-2"
      key = "s3-backend/backend-demo"
  }
}

