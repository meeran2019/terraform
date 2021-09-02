
# variable is declared with keyword variable followed by variable name.variable.variable. 
# default is the default value will be passed. 
# it can be refer by using the var.variable-name.attribute-name

# VARIABLE PRECEDENCE
# -var or -var-file in CLI > *.auto.tfvars or *.auto.tfvars.json > terraform.tfvars.json > terraform.tfvars


variable "internal-port" {
  type    = number
  default = 1100
}

# sensitive is used to hide the value display. NOTE: Still value will be shown in tfstate file. 

variable "external-port" {
  type      = number
  sensitive = true
}
