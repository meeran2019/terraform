
# to create the ec2 instance
resource "aws_instance" "web" {
  ami           = var.ami-value
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
}

# This is data template-file, used to render the template. 
data "template_file" "init" {
  template = "${file("init.tpl")}"
  vars = {
    consul_address = "${aws_instance.web.private_ip}"
  }
}


# Variables can be in separate file or in under same file. 
variable "ami-value" {
    default = "ami-0ca05c6eaa4ac40e0"
}

# Security group is required to open the SSH port 22 which allows connection from any source. 
resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}     
