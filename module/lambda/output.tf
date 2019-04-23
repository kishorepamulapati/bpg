output "test_lambda" {
  value = "${aws_lambda_function.test_lambda.arn}"
}
output "log" {
  value = "${aws_cloudwatch_log_group.log.arn}"
}