# optional support the IGW for the VDMS vpc if required 
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-igw"
    Owner          = "${var.owner}"
    Project        = "${var.project}"
  }
}

# optional suport for IGW route to public subnet
resource "aws_route" "igw_route" {
  route_table_id         = "${aws_route_table.pub.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}