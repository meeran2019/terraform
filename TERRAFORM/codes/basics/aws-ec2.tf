
# It creates the aws ec2 instance. 

resource "aws_instance" "web" {
  ami           = var.ami-value
  instance_type = "t2.nano"

  tags = {
    Name = "HelloWorld"
  }
}

