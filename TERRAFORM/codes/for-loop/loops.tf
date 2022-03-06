

# Example on using of count and count.index
resource "aws_instance" "web" {
  ami           = var.ami-value
  instance_type = "t2.micro"
  count         = 3
  tags = {
    Name = "dev-${count.index}"
  }
}

# Variables can be in separate file or in under same file. 
variable "ami-value" {
  default = "ami-0ca05c6eaa4ac40e0"
}

output "private-ip" {
  value = { for instances in aws_instance.web : instances.id => instances.private_ip }
}
