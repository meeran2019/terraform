
# It creates the aws ec2 instance. 
resource "aws_instance" "web" {
  ami           = var.ami-value
  instance_type = "t2.micro"
  key_name = "ec2-server"
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name = "HelloWorld"
  }

# This is local-exec provisioner, execute on the local machine. No need of connection.   
  provisioner "local-exec" {
    command = "echo local exec provisioner"
  }

# This is to copy file from local machine to remote machine. Connection is requuired. 
  provisioner "file" {
    source = "./script.sh"
    destination = "/tmp/"    
  }

# To execute on remote machine. Connection is required. 
provisioner "remote-exec" {
   inline = ["mkdir /tmp/test-dir"]
  }
  
# To connect to the remote machine.
# private_key name should be same as key in ec2 creation. 
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/home/meeran/Downloads/ec2-server.pem")
    host = "${aws_instance.web.public_ip}"
    timeout = "4m"
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
