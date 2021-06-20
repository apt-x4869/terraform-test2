/* NAT count  */
locals {
  nat_subnet = module.public_subnets["${var.nat_subnet}"].subnets
}
locals {
  nat_gateway_count = min(length(local.azs), length(local.nat_subnet))
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  count = local.nat_gateway_count
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}


/* NAT  */
resource "aws_nat_gateway" "nat" {
  count = local.nat_gateway_count
  allocation_id = element( aws_eip.nat_eip.*.id , count.index )
  subnet_id     = "${element(local.nat_subnet, count.index)}"
  depends_on    = [aws_internet_gateway.ig, aws_eip.nat_eip]
  tags = {
    Name        = "${var.vpc_name}-NAT-${length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : count.index }"
  }
}
