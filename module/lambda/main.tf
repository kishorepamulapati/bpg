provider "aws" {
  region = "us-east-1"
}
resource "aws_api_gateway_rest_api" "api_gate_way" {
  name        = "ebizapi"
  description = "This is my API "
}
resource "aws_api_gateway_stage" "test" {
  stage_name    = "prod"
  rest_api_id   = "${aws_api_gateway_rest_api.api_gate_way.id}"
  deployment_id = "${aws_api_gateway_deployment.test.id}"
 access_log_settings {
    destination_arn = "${var.log}"
    format = "$context.identity.sourceIp,$context.identity.caller,$context.identity.user,$context.requestTime,$context.httpMethod,$context.resourcePath,$context.protocol,$context.status,$context.responseLength,$context.requestId"
  }
}
resource "aws_api_gateway_deployment" "test" {
  depends_on  = ["aws_api_gateway_integration.test"]
  rest_api_id = "${aws_api_gateway_rest_api.api_gate_way.id}"
  stage_name  = "dev"
}
resource "aws_api_gateway_resource" "My_Demo_api" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gate_way.id}"
  parent_id   = "${aws_api_gateway_rest_api.api_gate_way.root_resource_id}"
  path_part   = "mydemoapi"
}
resource "aws_api_gateway_method" "test" {
  rest_api_id   = "${aws_api_gateway_rest_api.api_gate_way.id}"
  resource_id   = "${aws_api_gateway_resource.My_Demo_api.id}"
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_authorizer" "demo" {
  name = "demo"
  rest_api_id = "${aws_api_gateway_rest_api.api_gate_way.id}"
  authorizer_uri = "${aws_lambda_function.test_lambda.invoke_arn}"
  authorizer_credentials = "${var.invocation_role}"
}

 resource "aws_api_gateway_account" "demo" {
    cloudwatch_role_arn = "${var.cloudwatch}"
  }

resource "aws_cloudwatch_log_group" "log" {
  name = "/apigateway/stage_Log"
}

resource "aws_api_gateway_integration" "test" {
  rest_api_id = "${aws_api_gateway_rest_api.api_gate_way.id}"
  resource_id = "${aws_api_gateway_resource.My_Demo_api.id}"
  http_method = "${aws_api_gateway_method.test.http_method}"
  type        = "MOCK"
}

resource "aws_lambda_function" "test_lambda" 
{
  filename = "${path.module}/lambdas3.zip"
  function_name = "lambda_fun-ebizon"
   role = "${var.lambda}"
  handler = "lambdas3.sample"
  runtime = "python2.7"
}
