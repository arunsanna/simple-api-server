variable "project" {
  default = "arun"
}

variable "region" {
  default = "us-west-1"
}

variable "owner" {
  default = "sanna.arunchowdary@gmail.com"
}

variable "dns_support" {
  default = ""
}

# Flexible AZ / subnets and CIDR layout.
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "cidr_bits" {
  default = 8
}

variable "avalibity_zone" {
  default = "us-west-1a"
}

variable "instance-type" {
  default = "t2.micro"
}

variable "ami-id" {
  default = "ami-0ec1ad91f200c15a8"
}

variable "myip-address" {
  default = "144.217.198.17/32"
}