
# This is main program
# Module is used to refer the module with module name. 
# we can also pass the variable value from main to module. To pass value, in module, variable should be declared and pass the value after source. 


module "image-source" {
  source               = "../image"
  pass-image-from-main = "busybox"
}


# Once module is declared with name and source. Refer the module by using module.module-name.module-detils. 

resource "docker_container" "busybox_container" {
  name    = "busybox-container"
  image   = module.image-source.image_output
  command = ["sleep", "3600"]
  depends_on = [module.image-source]
}
