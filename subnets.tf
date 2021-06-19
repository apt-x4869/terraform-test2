// Creating 3 Private and 1 Public Subnet

data "aws_availability_zones" "available" { }

locals {
  azs = length(var.azs) > 0 ? var.azs : data.aws_availability_zones.available.names
}


module "private_subnets" {
  source = "./modules/subnet"

  region = var.region
  azs = local.azs
  for_each = var.private_subnet

  vpc_id = local.vpc_id
  vpc_name = var.vpc_name
  
  subnet = each.value
  subnet_name = each.key

  route_table_id = local.private_route_table_id
}

module "public_subnets" {
  source = "./modules/subnet"

  region = var.region
  azs = local.azs
  for_each = var.public_subnet

  vpc_id = local.vpc_id
  vpc_name = var.vpc_name
  
  subnet = each.value
  subnet_name = each.key

  route_table_id = local.public_route_table_id
}


/*
resource "aws_subnet" "private_subnet" {
    count =  length(var.private_subnet) > 0 ? length(var.private_subnet) : 0
    #count =  length(var.private_subnet) >= length(local.azs) ? length(var.private_subnet) : 0
    vpc_id = "${local.vpc_id}"
    
    cidr_block = "${var.private_subnet[count.index]}"
    availability_zone= length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.vpc_name}-private-${length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : count.index }"
    }
}

resource "aws_subnet" "public_subnet" {
  count =  length(var.public_subnet) > 0 ? length(var.public_subnet) : 0
  vpc_id = "${local.vpc_id}"
  
  cidr_block = "${var.public_subnet[count.index]}"
  
  availability_zone= length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.vpc_name}-public-${length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null }"
  }
}


resource "aws_subnet" "k8s_subnet" {
    count =  length(var.k8s_subnet) > 0 ? length(var.k8s_subnet) : 0
    #count =  length(var.private_subnet) >= length(local.azs) ? length(var.private_subnet) : 0
    vpc_id = "${local.vpc_id}"
    
    cidr_block = "${var.k8s_subnet[count.index]}"
    availability_zone= length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : null
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.vpc_name}-k8s-private-${length(regexall("^[a-z]{2}-", element(local.azs, count.index))) > 0 ? element(local.azs, count.index) : count.index }"
    }
}
*/