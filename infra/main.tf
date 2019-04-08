# we need to lock the provider version, enforcing same version
provider "aws" {
  version = "~> 1.24.0"
  region = "${var.region}"
  profile = "${var.profile}"
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

# creation of the VPC for infra deployment
resource "aws_vpc" "vpc" {
  cidr_block         = "${var.vpc_cidr_block}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-vpc"
    Owner          = "${var.owner}"
    Project        = "${var.project}"
  }
}

# Egress to the VPC only.
resource "aws_security_group" "vpc-egress" {
  name        = "${var.project}-vpc-egress"
  description = "Egress to same VPC"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-vpc-egress"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}

# Egress to anywhere
resource "aws_security_group" "all-egress" {
  name        = "${var.project}-all-egress"
  description = "Egress to anywhere"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-all-egress"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}

resource "aws_security_group_rule" "all-egress-rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.all-egress.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow egress to anywhere"
}

resource "aws_subnet" "pub" {
  availability_zone = "${var.avalibity_zone}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr_block, var.cidr_bits,1)}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-pub-subnet"
    Owner          = "${var.owner}"
  }
}

resource "aws_subnet" "priv" {
  availability_zone = "${var.avalibity_zone}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr_block, var.cidr_bits,2)}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-priv-subnet}"
    Owner          = "${var.owner}"
    Project        = "${var.project}"
  }
}

resource "aws_route_table" "pub" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-pub"
    Owner          = "${var.owner}"
    Project        = "${var.project}"
  }
}

resource "aws_route_table" "priv" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-priv"
    Owner          = "${var.owner}"
    Project        = "${var.project}"
  }
}

resource "aws_route_table_association" "pub" {
  route_table_id = "${aws_route_table.pub.id}"
  subnet_id      = "${aws_subnet.pub.id}"
}

resource "aws_route_table_association" "priv" {
  route_table_id = "${aws_route_table.priv.id}"
  subnet_id      = "${aws_subnet.priv.id}"
}