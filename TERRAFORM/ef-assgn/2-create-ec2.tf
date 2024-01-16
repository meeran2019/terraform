#with-count

resource "aws_instance" "ec2" {
  count = 3
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
}


#without-count

resource "aws_instance" "example" {
  for_each = var.instance_types
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = each.value


}