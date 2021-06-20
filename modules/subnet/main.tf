/*
provider "aws" {
  region = var.region
}
*/
data "aws_availability_zones" "available" { }

locals {
  azs = length(var.azs) > 0 ? var.azs : data.aws_availability_zones.available.names
}

resource "aws_subnet" "subnet" {
    count =  length(var.subnet)
    vpc_id = "${var.vpc_id}"
    
    cidr_block = "${var.subnet[count.index]}"
    availability_zone= length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.vpc_name}-${var.subnet_type}-${var.subnet_name}-${length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : count.index }"
    }
}

resource "aws_route_table_association" "rt_ass" {
  count = length(aws_subnet.subnet)

  subnet_id = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = element( var.route_table_id, count.index )
}

