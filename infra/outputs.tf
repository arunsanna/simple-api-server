output "elb_address" {
  value = "${aws_elb.app-elb.dns_name}"
}

output "keypair" {
  value = "${var.keypair}"
}

output "bastion-ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "profile" {
  value = "${var.profile}"
}

output "myip-address" {
  value = "${var.myip-address}"
}