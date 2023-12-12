resource "aws_vpc_endpoint" "s3-bucket" {
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_id       = var.vpc-id
}
resource "aws_vpc_endpoint_route_table_association" "route-table" {
  route_table_id  = var.routetable
  vpc_endpoint_id = aws_vpc_endpoint.s3-bucket.id
  TOKEN           = "{var.token}"
}
