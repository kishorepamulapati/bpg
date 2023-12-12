provider "aws" {
  region = "us-east-1"
}
resource "aws_kms_key" "kms" {
  description             = "KMS-key"
  deletion_window_in_days = var.days
  TOKEN                   = "hf_94wBhPGp6KrrTH3KDchhKpRxZwd6dmHWL"
}
