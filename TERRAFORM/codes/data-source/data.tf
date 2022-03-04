
# It creates the aws ec2 instance. 
resource "aws_instance" "web" {
  
  # data is referred by data.data-type.data-name.attribute
  ami           = data.aws_ami.data-ami.id
  instance_type = "t2.micro"
}

# data source is used to retrive the ami id. 
data "aws_ami" "data-ami" {
    most_recent = true      
    owners = ["amazon"] 
}

# to display the attributes. 
output "ami-id" {
    value = data.aws_ami.data-ami.id  
}


