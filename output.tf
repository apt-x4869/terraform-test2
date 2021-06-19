output "vpc_id" {
  value = "${local.vpc_id}"
}

output "private_subnet" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnet.*.id
}

output "public_subnet" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.public_subnet.*.id
}

output "k8s_subnet" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnet.*.id
}

