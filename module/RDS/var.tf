
variable "engine" {
  default = "aurora-postgresql"
}
variable "db_name" {
  default = "kishore"
}

variable "username" {
  default = "Ebizoncloud"
}
variable "password" {
  default = "pvkishore"
}
variable "available_az" {
  type = "list"
  default =["us-east-1d","us-east-1b"]
}
variable "kms" {
  default = ""
}
variable "sg-id" {
  default ="sg-08605275a29dab0fe"
}
variable "db_subnet" {
  type = "list"
  default = ["subnet-79b88452","subnet-48050911"]
}