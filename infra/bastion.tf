resource "aws_security_group" "bastion-sg" {
  name        = "${var.project}-bastion"
  description = "Bastion instance security group"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-bastion-security-group"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}

resource "aws_security_group_rule" "bastion-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.bastion-sg.id}"
  cidr_blocks       = ["${var.myip-address}"]
  description       = "allow ssh access to my IP address"
}

resource "aws_security_group_rule" "bastion-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.bastion-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "All Access for outbound"
}

resource "aws_instance" "bastion" {
  ami           = "${var.ami-id}"
  instance_type = "${var.instance-type}"
  availability_zone = "${var.availability_zone}"
  key_name = "${var.keypair}"
  vpc_security_group_ids = ["${aws_security_group.bastion-sg.id}"]
  subnet_id = "${aws_subnet.pub.id}"
  associate_public_ip_address = true

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-bastion-instance"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}
