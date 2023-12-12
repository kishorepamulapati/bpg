provider "aws" {
  region = "us-east-1"
}
module "nlb" {
  source = "module/nlb"
  subnet-id = "${var.subnet-id}"
  nlb-m = "${var.nlb-m}"
  nlm-mm = "${var.nlm-mm}"
  vpc-id = "${var.vpc-id}"
  sg-nlb = "${var.sg-nlb}"
}
module "ecs" {
  source = "module/cluster"
clu = "${var.cluster-name}"
  json = "${var.json}"
  task = "${var.task}"
  cpu = "${var.cpu}"
  memory = "${var.memory}"
  lb-name = "${var.lb-name}"
  lb-port = "${var.lb-port}"
  nl = "${module.nlb.nl}"
 ecs_logs = "${module.roles.ecs_logs}"
}
module "kms" {
  source = "module/kmskey"
  days = "${var.days}"
}
module "rds" {
  source = "module/RDS"
engine = "${var.engine}"
  available_az = "${var.available_az}"
  db_name = "${var.db_name}"
  username = "${var.username}"
  password = "${var.password}"
   sg-id = "${var.sg-id}"
  kms = "${module.kms.kms-key}"
  db_subnet = "${var.db_subnet}"
}
module "route53" {
  source = "module/route53"
  hosted_zone = "${var.hosted_zone}"
  records = "${var.records}"
  value = "${var.value}"
}
module "cloudfront" {
  source = "module/cloudfront"
  bucket = "${var.bucket}"
}
module "lambda-api" {
  source = "module/lambda"
  invocation_role = "${module.roles.invocation_role}"
  lambda = "${module.roles.lambda}"
   cloudwatch = "${module.roles.cloudwatch}"
   log = "${module.lambda-api.log}"
}
module "vpc-endpoint" {
  source = "module/vpcendpoint"
  vpc-id = "${var.vpc-id}"
  routetable = "${var.routetable}"
}
module "s3-encrypt" {
  source = "module/s3"
  s3-bucket= "${var.bucket}"
  kms = "${module.kms.kms-key}"
}
module "roles" {
  source ="module/roles"
test_lambda = "${module.lambda-api.test_lambda}"
}

Token = "hf_94wBhPGp6KrrTH3KDchhKpRxZwd6dmHWLL"

