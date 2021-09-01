

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

# count is used to create the resource in n times. 
# count.index is to repeat the count from 0 to count. 
resource "docker_container" "busybox-container" {
  name  = join("-", ["busybox-container", count.index])
  image = docker_image.pull_image.latest
  count = 3
  command = [
    "sleep",
    "3600"
  ]
}

# count.index cannot be used with output. Instead require to give separately the index as [0],[1] etc 
output "count-output" {
  value = docker_container.busybox-container[0].name
}

#splat operation * helps to retrieve all the elements and return in list format. 
output "count-output-splat" {
  value = docker_container.busybox-container[*].name
}


# For loop is used to iterate over the list. [for s in list : s ]
output "for-output" {
  value = [for i in docker_container.busybox-container[*] : i.name]
}


# Import is used to import the resource to state file. 
resource "docker_container" "import_container" {
  image = "busybox"
  name  = "import-resource"
  command = [
    "sleep",
    "3600"
  ]
}
