
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
# validation is used to validate the condition. If condition is true then no error. If condition is false, then throw error. 
# for max function, max([list of values]...) min([list of values]...)  NOTE: ... (spread operator) is required. 
# in max validation, it can check list only. So to pass the key value of map. 
# For Prod validation, require to pass as max(list of map[key])


variable "external-port" {
  type = map(any)

  validation {
    condition     = max(var.external-port["dev"]...) < 2000 && min(var.external-port["dev"]...) > 1000
    error_message = "Validation is failed with invalid port."
  }
}

variable "container_count" {
  default = 3
}


# Locals are used to assign a name to expression. Below is the local declaration. 
# It is referred by using local.local-name. 


locals {
  local_count = length(lookup(var.external-port, var.environment))
}


variable "environment" {
  type        = string
  default     = "dev"
  description = "environement variables"
}

# Mapping is used to map based on the key/value pair. 
# Lookup is lookup(map,key,default). It returns the mapping based on the key value. 

variable "image-mapping" {
  type        = map(any)
  description = "image mapping example"
  default = {
    dev  = "busybox"
    prod = "ubuntu"
  }
}

# terraform.workspace cant refer using variables, so used the locals. 

locals {
  workspace-value = terraform.workspace
}
