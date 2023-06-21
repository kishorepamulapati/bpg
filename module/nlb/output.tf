output "nl" {
  value = "${aws_lb_target_group.target-nlb.*.arn}"
}
