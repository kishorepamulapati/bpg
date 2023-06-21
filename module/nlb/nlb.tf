provider "aws" {
  region = "us-east-1"
}
resource "aws_lb" "test" {
    name = "test-lb-tf"
    internal = true
    load_balancer_type = "network"
  subnets = ["${var.subnet-id}"]
    }
resource "aws_lb_listener" "nlb-listener" {
  "default_action" {
    type = "forward"
    target_group_arn = "${element(aws_lb_target_group.target-nlb.*.arn,count.index )}"
  }
  load_balancer_arn = "${aws_lb.test.arn}"
  count = "${length(var.nlm-mm)}"
  port = "${element(var.nlm-mm,count.index )}"
  protocol = "TCP"
}
resource "aws_lb_target_group" "target-nlb" {
  count ="${length(var.nlb-m)}"
  port =  "${element(var.nlb-m,count.index )}"
  target_type = "ip"
  protocol = "TCP"
  vpc_id = "${var.vpc-id}"
  health_check {
    timeout               = "6"
    healthy_threshold     = "3"
    unhealthy_threshold   = "3"
    interval              = "30"
    path                  = "/health"
  }
  stickiness {
    type = "lb_cookie"
    enabled = false
  }
 }

