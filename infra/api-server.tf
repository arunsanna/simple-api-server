resource "aws_security_group" "api-server-sg" {
  name        = "${var.project}-api-server-sg"
  description = "Bastion instance security group"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-api-server-security-group"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}

resource "aws_security_group_rule" "api-server-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.api-server-sg.id}"
  source_security_group_id = "${aws_security_group.bastion-sg.id}"
  description       = "allow ssh access from bastion"
}

resource "aws_security_group_rule" "server-elb-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.api-server-sg.id}"
  source_security_group_id = "${aws_security_group.api-xelb-sg.id}"
  description       = "allow ssh access to my IP address"
}

resource "aws_security_group_rule" "api-server-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.api-server-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "All Access for outbound"
}

resource "aws_instance" "api-server" {
  ami           = "${var.ami-id}"
  instance_type = "${var.instance-type}"
  availability_zone = "${var.avalibity_zone}"
  key_name = "arunsanna"
  vpc_security_group_ids = ["${aws_security_group.api-server-sg.id}"]
  subnet_id = "${aws_subnet.priv.id}"
  associate_public_ip_address = false
  user_data = "user-data/api-app.sh.tpl"
  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-API-Server"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}