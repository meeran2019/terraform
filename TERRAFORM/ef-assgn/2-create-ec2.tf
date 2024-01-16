#with-count

resource "aws_instance" "ec2-2a" {
  count = 2
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
}


#without-count

resource "aws_instance" "ec2-2b" {
  for_each = var.instance_types
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = each.value
}