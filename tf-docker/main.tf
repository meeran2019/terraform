
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
resource "docker_container" "busybox-container" {
  name  = "busybox-container"
  image = docker_image.pull_image.latest
  command = [
    "sleep",
    "3600"
  ]
  ports {
    internal = 1100
    external = 1100
  }
}


# This is to create the same resource using the random string resource option. 
resource "docker_container" "busybox-container-random" {
  name  = join("-", ["busybox-container", random_string.random-string.result])
  image = docker_image.pull_image.latest
  command = [
    "sleep",
    "3600"
  ]
}

# this random_string creates the random string. 
resource "random_string" "random-string" {
  length  = 5
  special = false
  upper   = false
}

# output is used to display the output value. 
output "container-ip-address" {
  value       = docker_container.busybox-container.ip_address
  description = "IP address of the container is"
}

output "container-name" {
  value       = docker_container.busybox-container.name
  description = "Name of the container is"
}

# join function is used to join the list using separator. join("separator",[list])
output "join-address" {
  value = join(":", [docker_container.busybox-container.ip_address, docker_container.busybox-container.name])
}

# to get the output of random-string. 
output "random-string" {
  value = random_string.random-string.result
}


