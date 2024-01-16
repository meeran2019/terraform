#Adding labels to the AWS Ec2 or GCP  compute instances as a whole (that is all the Ec2 instances will have the same name)

resource "aws_instance" "ec2-3a" {
  count = 3
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "ec2-3a"
  }
}


#the labels vary for each Ec2 instance

resource "aws_instance" "ec2-3b" {
  for_each = var.instance_types
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = each.value
  tags = {
    Name = each.value
  }
}