
# output is used to display the output value. 

output "container-ip-address" {
  value       = docker_container.busybox-container.ip_address
  description = "IP address of the container is"
}

output "container-name" {
  value       = docker_container.busybox-container.name
  description = "Name of the container is"
}

# for sensitive variable, while display it must be sensitive wlse throw error.

output "external-port" {
  value       = var.external-port
  sensitive   = true
  description = "Name of the container is"
}