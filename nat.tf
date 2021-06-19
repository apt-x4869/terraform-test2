/* NAT count */
locals {
  nat_gateway_count = min(length(local.azs), length(aws_subnet.public_subnet))
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  count = local.nat_gateway_count
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}


/* NAT */
resource "aws_nat_gateway" "nat" {
  count = local.nat_gateway_count
  allocation_id = element( aws_eip.nat_eip.*.id , count.index )
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  depends_on    = [aws_internet_gateway.ig, aws_eip.nat_eip]
  tags = {
    Name        = "${var.vpc_name}-NAT-${element(aws_subnet.public_subnet.*.availability_zone, count.index)}"
  }
}
