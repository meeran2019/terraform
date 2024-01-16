variable "instance_types" {
  type = map
  default = {
    instance1 = "t2.micro",
    instance2 = "t2.nano"
  }
}