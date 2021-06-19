output "subnets" {
    value = [ for x in aws_subnet.subnet:  x.*.id[0] ]
}