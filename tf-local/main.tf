
# variables can be passed in different ways,
# 1. If value is not given/passed, then it will prompt for the value.variable. 
# 2. It can given during command as -var variable-name=value 
# 3. Use the default in variable declarion. 
# 4. Use the environement variable as TF_VAR_variable-name=value


# This is sample example to pull docker image from docker hub.
# It requires to login to docker with "docker login" command.
# This block requires to identify the provider and gives the version. 

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  # Configuration options
}

# It tells which resource to create and consists of resource type and resource name. After execute this resource,
# it gives ouput(attributes). Please refer the documentation for attribute details or tfstate file. 

resource "docker_image" "pull_image" {
  name = "busybox"
}

# Referencing the other resources. It consists of resource-type.resource-name.output-of-resource. 
# NOTE: Container will be exited immediately and will throw error and to use the sleep command to run longer. 
# Port is used to access externally in docker. 
# var is used to refer the declared variable. 
# volumes is used to map the host and container port. 

resource "docker_container" "busybox-container" {
  name  = join("-", ["busybox-container", count.index])
  image = docker_image.pull_image.latest
  count = local.local_count
  command = [
    "sleep",
    "3600"
  ]
  ports {
    internal = var.internal-port
    external = var.external-port[count.index]
  }
}

