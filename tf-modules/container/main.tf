
resource "docker_container" "busybox_container" {
  name    = "busybox-container"
  image   = var.image_input
  command = ["sleep", "3600"]

}

