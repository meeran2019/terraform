

resource "aws_instance" "web" {
  ami = var.ami-value
  for_each = var.instance-type
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

output "output-of-module" {
    value = values(aws_instance.web)
  
}