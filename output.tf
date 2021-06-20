output "vpc_id" {
  value = "${local.vpc_id}"
}

output "private_subnets" {
  value = [ for x in module.private_subnets:  { "${x.name}" = x.*.subnets[0] } ]
}

output "public_subnets" {
  value = [ for x in module.public_subnets:  { "${x.name}" = x.*.subnets[0] } ]  
}