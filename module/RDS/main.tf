provider "aws" {
  region = "us-east-1"
}
resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "demo"
  engine                  = "${var.engine}"
  engine_version = "10.6"
  availability_zones = "${var.available_az}"
 db_subnet_group_name ="${aws_db_subnet_group.postgesql-db-subnet-group.name}"
 database_name           = "${var.db_name}"
  master_username         = "${var.username}"
  master_password         = "${var.password}"
  backup_retention_period = 0
  skip_final_snapshot = "true"
  vpc_security_group_ids = ["${var.sg-id}"]
  storage_encrypted = "true"
  kms_key_id = "${var.kms}"


}
resource "aws_rds_cluster_instance" "postgresql"
{
  cluster_identifier = "${aws_rds_cluster.postgresql.id}"
  instance_class = "db.r4.large"
  engine = "${var.engine}"
  db_subnet_group_name ="${aws_db_subnet_group.postgesql-db-subnet-group.name}"
}
resource "aws_db_subnet_group" "postgesql-db-subnet-group" {
    name="postgresqlbd"
  subnet_ids = ["${var.db_subnet}"]
}

