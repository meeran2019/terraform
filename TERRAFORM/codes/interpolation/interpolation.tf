
# Here module is used to create ec2. 
# condition?true-value:false-value 

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name                   = "single-instance"
  ami                    = "${var.ami-value}"
  instance_type          = "${var.env-region}" == "dev" ? "t2.nano" : "t2.micro"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Variable is used to pass input variable. 
variable "ami-value" {
    default = "ami-0ca05c6eaa4ac40e0" 
}

variable "env-region" {
    default = "dev"
}
