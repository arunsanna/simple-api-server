resource "aws_eip" "nat" {
  vpc        = true

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-nat-eip"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.pub.id}"
  depends_on    = ["aws_internet_gateway.igw"]

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-nat-gateway"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}

resource "aws_route" "nat_gateway_route" {
  route_table_id         = "${aws_route_table.priv.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}