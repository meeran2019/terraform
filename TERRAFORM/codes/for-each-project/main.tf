
# It creates the aws ec2 instance. 
resource "aws_instance" "web" {
  ami = var.ami-value
  # instance_type = "t2.micro"
  for_each      = var.instance-type
  instance_type = each.value
}

# Variables can be in separate file or in under same file. 
variable "ami-value" {
  default = "ami-0cabc39acf991f4f1"
}

variable "instance-type" {
  type    = set(string)
  default = ["t2.micro", "t2.nano"]
}

output "instance-ids" {
  value = {for key, value in aws_instance.web: key => value.id}
  
}
