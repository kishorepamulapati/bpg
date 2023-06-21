provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "s3bucket" {
  bucket = "pvkbuckettf"
  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${var.kms}"
        sse_algorithm = "aws:kms"
      }
    }
  }
}