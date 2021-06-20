################################################################################
# Private routes
# There are as many routing tables as the number of NAT gateways
################################################################################

/* Routing table for private subnet */
resource "aws_route_table" "private" {
    count = local.nat_gateway_count
    vpc_id = "${local.vpc_id}"
    tags = {
        Name = "${var.vpc_name}-private-rt-${length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : count.index }"
    }
}

/* Private Routes */
resource "aws_route" "private_nat_gateway" {
    count = local.nat_gateway_count
    route_table_id         = element(aws_route_table.private.*.id, count.index)
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
    timeouts {
        create = "5m"
    }
}

locals {
  private_route_table_id = aws_route_table.private.*.id 
}
/*

// Route Table Association 
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet)

  subnet_id = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element( aws_route_table.private.*.id, count.index )
}

// K8s Subnet Association 
resource "aws_route_table_association" "k8s" {
  count = length(var.k8s_subnet)

  subnet_id = element(aws_subnet.k8s_subnet.*.id, count.index)
  route_table_id = element( aws_route_table.private.*.id, count.index )
}

*/

################################################################################
# Publiс routes
################################################################################

/* Routing table for public subnet */
resource "aws_route_table" "public" {
    vpc_id = "${local.vpc_id}"
    tags = {
        Name = "${var.vpc_name}-public-rt"
    }
}

locals {
  public_route_table_id = [ aws_route_table.public.id ]
}



/* Routes */
resource "aws_route" "public_internet_gateway" {
  
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id

  timeouts {
    create = "5m"
  }
}


/*
################################################################################
# Route Table Association
# Associating All Public Subnets to Public Route Table
################################################################################
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}


*/