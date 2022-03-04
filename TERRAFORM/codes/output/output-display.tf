
output "ip-address" {
    value = aws_instance.web.public_ip
}

output "arn" {
    value = aws_instance.web.arn
}
