
# for sensitive variable, while display it must be sensitive wlse throw error.

output "external-port" {
  value       = var.external-port
  description = "Name of the container is"
}

# function cannot use directl in variable. 
# locals are used to assign a expression to the name. 
# can use that local name in multiple times with in the script. 

output "local-count" {
  value       = local.local_count
  description = "Name of the container is"
}