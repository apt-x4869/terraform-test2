output "subnets" {
    value = [ for x in aws_subnet.subnet:  x.*.id[0] ]
}

output "name" {
    value = var.subnet_name
}