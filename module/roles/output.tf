output "invocation_role" {
  value = "${aws_iam_role.invocation_role.arn}"
}
output  "lambda" {
  value = "${aws_iam_role.lambda.arn}"
}
output "ecs_logs" {
  value = "${aws_iam_role.ecs_logs.arn}"
}
output "cloudwatch" {
  value = "${aws_iam_role.cloudwatch.arn}"
}