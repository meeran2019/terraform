
# This is sample example to pull docker image from docker hub.
# It requires to login to docker with "docker login" command.
  

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  # Configuration options
}

resource "docker_image" "pull_image" {
    name = "busybox"  
}
