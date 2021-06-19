/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = "${local.vpc_id}"
  tags = {
    Name        = "${var.vpc_name}-igw"
  }
}