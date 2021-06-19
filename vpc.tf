resource "aws_vpc" "main" {
    count = var.existing_vpc ? 0 : 1
    cidr_block       = var.cidr_block
    instance_tenancy = "default"
    tags = {
        Name = "${var.vpc_name}"
        }
}

locals {
  vpc_id = var.existing_vpc ? var.vpc_id : aws_vpc.main[0].id
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  count      = length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0
  vpc_id     = local.vpc_id
  cidr_block = element(var.secondary_cidr_blocks, count.index)
}
