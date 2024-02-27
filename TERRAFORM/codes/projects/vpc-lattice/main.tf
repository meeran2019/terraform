## To create the service network.
resource "aws_vpclattice_service_network" "example" {
  name      = "example"
  auth_type = "AWS_IAM"
}

## To create the service.
resource "aws_vpclattice_service" "example" {
  name               = "example"
  auth_type          = "AWS_IAM"
  custom_domain_name = "example.com"
}

## To associate service with service network.
resource "aws_vpclattice_service_network_service_association" "example" {
  service_identifier         = aws_vpclattice_service.example.id
  service_network_identifier = aws_vpclattice_service_network.example.id
}

## To create the security group for the VPC-Service Network Association.
resource "aws_security_group" "example" {
  name   = "sg"
  vpc_id = aws_vpc.example.id

  ingress = []
  egress  = []
}

## To associate VPC to service network.
resource "aws_vpclattice_service_network_vpc_association" "example" {
  vpc_identifier             = aws_vpc.example.id
  service_network_identifier = aws_vpclattice_service_network.example.id
  security_group_ids         = [aws_security_group.example.id]
}

## To create the target group.
resource "aws_vpclattice_target_group" "example" {
  name = "example"
  type = "INSTANCE"

  config {
    vpc_identifier = aws_vpc.example.id

    port     = 443
    protocol = "HTTPS"
  }
}

