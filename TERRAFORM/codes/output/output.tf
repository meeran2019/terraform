
# It creates the aws ec2 instance. 
resource "aws_instance" "web" {
  ami           = var.ami-value
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }    
  provisioner "local-exec" {
      # NOTE: here to use ${variable} to fetch the value. 
    command = "echo ${aws_instance.web.arn} >> arn.txt"
  }
}

# Variables can be in separate file or in under same file. 
variable "ami-value" {
    default = "ami-0ca05c6eaa4ac40e0"
}

