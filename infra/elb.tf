# Create a new load balancer
resource "aws_elb" "app-elb" {
  name               = "${var.project}-app-XELB"
  security_groups = ["${aws_security_group.api-xelb-sg.id}"]
  subnets = ["${aws_subnet.pub.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  instances                   = ["${aws_instance.api-server.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}

resource "aws_security_group" "api-xelb-sg" {
  name        = "${var.project}-api-xelb-sg"
  description = "XELB security group"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    CreatedBy      = "${var.owner}"
    Name           = "${var.project}-api-xelb-security-group"
    Project        = "${var.project}"
    Owner          = "${var.owner}"
  }
}


resource "aws_security_group_rule" "api-xelb-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${var.myip-address}"]
  security_group_id = "${aws_security_group.api-xelb-sg.id}"
  description       = "allow http access from my ipaddress"
}

resource "aws_security_group_rule" "api-xelb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.api-xelb-sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "All Access for outbound"
}