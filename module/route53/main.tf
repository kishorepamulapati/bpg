provider "aws" {
  region = "us-east-1"
}
resource "aws_route53_zone" "hotsed_zone" {
  name = "${var.hosted_zone}"
}
resource "aws_route53_record" "record" {
  zone_id = "${aws_route53_zone.hotsed_zone.zone_id}"
  name    = "${var.records}"
  type    = "A"
  ttl     = "300"
  records = ["${var.value}"]
}
